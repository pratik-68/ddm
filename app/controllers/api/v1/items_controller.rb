# frozen_string_literal: true

class Api::V1::ItemsController < ApplicationController

  # User specific items
  def user_items
    authorize Item
    page = params.fetch(:page, 1).to_i
    return bad_response(message: 'Invalid Request') unless page.positive?

    @items = Item.where(user: current_user, group_buying: 0)
               .limit(10).offset((page - 1) * 10).order(:bidding_end_time)
    count = Item.where(user: current_user, group_buying: 0).count
    render json: @items, 'meta': { 'total_count': count }
  end

  # All Items
  def index
    authorize Item
    page = params.fetch(:page, 1).to_i
    return bad_response(message: 'Invalid Request') unless page.positive?

    @items = Item.where(
      'bidding_end_time > :time AND NOT user_id = :user_id',
      time: Time.current - 1.hour, user_id: current_user.id
    ).limit(10).offset((page - 1) * 10).order(:bidding_end_time)
    count = Item.where(
      'bidding_end_time > :time AND NOT user_id = :user_id',
      time: Time.current - 1.hour, user_id: current_user.id
    ).count
    render json: @items, 'meta': { 'total_count': count },
           scope: { status: true }
  end

  def show
    @item = Item.find_by(id: params[:id])
    return not_found_response unless @item.present?

    authorize @item
    render json: @item, scope: {
      detail: true, item_owner: item_owner?(@item)
    }
  end

  def create
    authorize Item

    desc = [] # Suggest any name it have list of label and detail data
    if description_params.present?
      description_params.each do |description|
        if description[:label].present? && !description[:detail].present?
          return bad_response(detail: 'can\'t be blank')
        end
        if !description[:label].present? && description[:detail].present?
          return bad_response(label: 'can\'t be blank')
        end
        if description[:label].present? && description[:detail].present?
          desc.push(label: description[:label], detail: description[:detail])
        end
      end
    end

    @item = Item.new(item_params)
    @item.user = current_user
    @item.descriptions.push(Description.create(desc))

    if @item.save
      if @item.is_group_buying?
        GroupBuying.create(
          item_id: @item.id, user: current_user, quantity: @item.quantity
        )
      end

      # Mail to buyer
      NewItemMailerForBuyerJob.perform_later(current_user, @item)

      # Mail to Seller
      NewItemMailerForSellerJob.perform_later(current_user, @item)

      # Bidding Start mail
      BiddingMailerJob.set(
        wait_until: @item.bidding_start_time
      ).perform_later(current_user, @item)

      # Winner Decision
      BidWinnerJob.set(
        wait_until: @item.buffer_end_time
      ).perform_later(current_user, @item)

      render json: @item, scope: { detail: true, item_owner: true }, status: 201
    else
      bad_response(@item.errors)
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :name, :description, :max_amount, :status, :bidding_end_time,
      :quantity, :group_buying
    )
  end

  def description_params
    if params[:descriptions].present?
      params.permit(descriptions: %i[label detail]).require(:descriptions)
    end
  end

  def item_owner?(item)
    return true if item.user == current_user

    GroupBuying.exists?(item: item, user: current_user) if item.is_group_buying?
  end
end
