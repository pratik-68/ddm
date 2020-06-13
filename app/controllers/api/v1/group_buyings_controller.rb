class Api::V1::GroupBuyingsController < ApplicationController

  def user_items
    authorize Item, policy_class: GroupBuyingPolicy
    page = params.fetch(:page, 1).to_i
    return bad_response(message: 'Invalid Request') unless page.positive?

    @items = Item.includes(:group_buyings).where(
      group_buyings: { user: current_user }
    ).limit(10).offset((page - 1) * 10).order(:bidding_end_time)

    count = Item.includes(:group_buyings).where(
      group_buyings: { user: current_user }
    ).count
    render json: @items, 'meta': { 'total_count': count }
  end

  # All Group Buying List
  def index
    authorize Item, policy_class: GroupBuyingPolicy
    page = params.fetch(:page, 1).to_i
    return bad_response(message: 'Invalid Request') unless page.positive?

    @items = Item.includes(:group_buyings).where(
      "bidding_end_time > '#{Time.current}' AND group_buying = 1",
    ).limit(10).offset((page - 1) * 10).order(:bidding_end_time)

    count = Item.includes(:group_buyings).where(
      "bidding_end_time > '#{Time.current}' AND group_buying = 1",
    ).count
    render json: @items, 'meta': { 'total_count': count }
  end

  def create
    @item = Item.find_by(id: params[:item_id])
    return bad_response(message: "Invalid Request") unless @item.present?

    authorize @item, policy_class: GroupBuyingPolicy
    if GroupBuying.exists?(item: @item, user: current_user)
      return bad_response(message: 'Already added in your list')
    end

    @obj = GroupBuying.new(group_buying_params)
    @obj.item = @item
    @obj.user = current_user
    if @obj.save
      @item.increment!(:quantity, @obj.quantity)
      return create_response({})
    end
    bad_response(@obj.errors)
  end

  private

  def group_buying_params
    params.require(:group_buying).permit(:quantity)
  end
end
