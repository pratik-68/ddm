class Api::V1::ChargesController < ApplicationController
  before_action :find_item, only: %i[charge_bid]
  before_action :find_transaction, only: %i[show update]
  rescue_from Stripe::StripeError, with: :catch_exception
  
  serialization_scope :current_user

  def show
    authorize @transaction
    success_response(@transaction)
  end

  def index
    skip_authorization
    page = params.fetch(:page, 1).to_i
    if page.positive?
      charges = Transaction.where(user: current_user)
                  .limit(10).offset((page - 1) * 10).order(:created_at)
      count = Transaction.where(user: current_user).count
      return render json: charges, 'meta': { 'total_count': count }
    end
    bad_response(message: 'Invalid Request')
  end

  def update
    valid = StripeChargesServices.new.confirm_transaction(@transaction)
    return bad_response(@transaction.errors) unless valid.present?

    BidRegistrationMailerForSellerJob.perform_later(current_user, @item, @bid)
    BidRegistrationMailerForBuyerJob.perform_later(@item, @bid)
    success_response(@transaction)
  end

  private

  def find_transaction
    @transaction = Transaction.find_by(transaction_id: params[:id])
    not_found_response unless @transaction.present?
  end

  def catch_exception(exception)
    bad_response(message: exception.message)
  end

  def find_item
    @item = Item.find_by(id: params.fetch(:item_id))
    not_found_response(error: 'Item Not found') unless @item.present?
  end
end
