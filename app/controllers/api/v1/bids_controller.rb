# frozen_string_literal: true

# Bid Create
class Api::V1::BidsController < ApplicationController
  before_action :find_item

  serialization_scope :user

  # @return [JSON Data]
  def index
    authorize @item, policy_class: BidPolicy
    page = params.fetch(:page, 1).to_i
    return bad_response(message: 'Invalid Request') unless page.positive?

    if item_owner?
      @bid = Bid.joins(:transactions).where(
        item: @item, transactions: { status: 1, transaction_type: 1 }
      ).limit(10).offset((page - 1) * 10).order(:created_at)
      count = Bid.joins(:transactions).where(
        item: @item, transactions: { status: 1, transaction_type: 1 }
      ).count
    else
      @bid = Bid.where(user_id: current_user, item_id: @item)
               .limit(10).offset((page - 1) * 10).order(:created_at)
      count = Bid.where(user_id: current_user, item_id: @item).count
    end

    render json: @bid, meta: { total_bid_count: count }
  end

  def top_bids
    authorize @item, policy_class: BidPolicy
    @bid = Bid.joins(:transactions).where(
      item: @item, transactions: { status: 1, transaction_type: 1 }
    ).limit(3).order(:amount)
    success_response(@bid)
  end

  def show
    @bid = Bid.find_by(id: params[:id])
    return not_found_response unless @bid.present?

    authorize @bid
    render json: @bid, scope: {
      show: true, bid_owner: current_user == @bid.user
    }
  end

  # @return [JSON Data]
  def create
    authorize @item, policy_class: BidPolicy
    desc = [] # Suggest any name it have list of label and detail data
    bid_params[:descriptions].each do |description|
      if description[:label].present? && !description[:detail].present?
        return bad_response(label: 'can\'t be blank')
      end
      if !description[:label].present? && description[:detail].present?
        return bad_response(detail: 'can\'t be blank')
      end

      if description[:label].present? && description[:detail].present?
        desc.push(label: description[:label], detail: description[:detail])
      end
    end

    @bid = Bid.new(
      name: bid_params[:name],
      amount: bid_params[:amount],
      user: current_user,
      item: @item
    )

    # TODO: Add Image
    # puts '=================================================================='
    # puts bid_params
    # @bid.images.attach(bid_params[:images])
    # puts '=================================================================='

    @bid.descriptions.push(Description.create(desc))
    if @bid.save
      @obj = StripeChargesServices.new.charge_bid(@bid, current_user)
      return create_response(id: @obj.id, token: @obj.token) if @obj.save

      bad_response(@obj.errors)
    end
    bad_response(@bid.errors)
  end

  def reject
    authorize @item, policy_class: BidPolicy
    @bid = Bid.find_by(item: @item, id: params[:bid_id])

    return bad_response(message: "Invalid Request") unless @bid.present?
    return bad_response(message: 'Bid already rejected') if @bid.rejected?
    return success_response({}) if @bid.bid_reject

    bad_response(@bid.errors)
  end

  def like
    authorize @item, policy_class: BidPolicy
    @bid = Bid.find_by(item: @item, id: params[:bid_id])

    return bad_response(message: "Invalid Request") unless @bid.present?
    return bad_response(message: 'Bid rejected') if @bid.rejected?

    @like = BidLike.find_by(bid: @bid, user: user, like: 1)

    return bad_response(message: 'Already Liked') if @like.present?

    @buyer = if @item.is_group_buying?
               GroupBuying.find_by(item: @item, user: user)
             else
               @item
             end

    @like = BidLike.new(bid: @bid, user: user, like: 1)
    if @like.save
      if @bid.increment!(:vote_count, @buyer.quantity)
        return create_response({})
      end
    else
      bad_response(@like.errors)
    end
  end

  # @return [JSON Data]
  def destroy
    authorize @item, policy_class: BidPolicy
    if @item.bidding_end_time <= Time.current
      return bad_response(
        message: 'Item can\'t be deleted after bidding end time'
      )
    end
    @bid = Bid.find_by(user: current_user, id: params[:id])
    return bad_response(message: "Invalid Request") unless @bid.present?
    return success_response({}) if @bid.soft_delete

    service_unavailable(error: { message: 'Something went wrong' })
  end

  private

  def user
    current_user
  end

  def bid_params
    params.require(:bid).permit(
      :name, :amount, descriptions: %i[label detail], images: []
    )
  end

  def find_item
    @item = Item.find_by(id: params.fetch(:item_id))
    not_found_response(error: 'Item Not found') unless @item.present?
  end

  def item_owner?
    return true if @item.user == current_user

    GroupBuying.exists?(item: @item, user: current_user) if @item.is_group_buying?
  end
end
