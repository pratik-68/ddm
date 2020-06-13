class StripeChargesServices
  DEFAULT_CURRENCY = 'inr'.freeze

  # def initialize(params, instance_obj, user)
  #   @amount = params[:amount]
  #   @instance_obj = instance_obj
  #   @user = user
  #   @paid_amount = @amount * 0.01 < 60 ? 60 : @amount * 0.01
  # end

  def charge_bid(instance_obj, user)
    @instance_obj = instance_obj
    @amount = instance_obj.amount
    @user = user
    @paid_amount = @amount * 0.01 < 60 ? 60 : @amount * 0.01
    create_customer
    create_transaction(create_intent, :paid)
  end

  def confirm_transaction(transaction)
    @transaction = transaction
    update_transaction(retrieve_intent)
  end

  def refund_transaction(transaction)
    @transaction = transaction
    create_transaction(refund_intent, :refund)
  end

  private

  attr_accessor :amount, :paid_amount, :instance_obj, :user, :transaction

  # Create Customer
  def create_customer
    return if user.customer_id.present?

    customer = Stripe::Customer.create(email: user.email)
    user.update(customer_id: customer[:id])
  end

  def create_charge(transaction)
    Stripe::Charge.create(
      customer: transaction.token,
      amount: transaction.paid_amount * 100,
      description: user.email,
      currency: DEFAULT_CURRENCY
    )
  end

  # Create Payment
  def create_intent
    Stripe::PaymentIntent.create(
      amount: (paid_amount * 100).to_int,
      currency: DEFAULT_CURRENCY,
      customer: user.customer_id,
      payment_method_types: [:card],
      description:
        "#{user.email}, #{instance_obj.class.name}_id: #{instance_obj.id}",
      metadata: {
        user: user.email,
        type: instance_obj.class.name,
        id: instance_obj.id
      }
    )
  end

  # Confirm Payment
  def confirm_intent
    Stripe::PaymentIntent.confirm(transaction.transaction_id)
  end

  # Retrieve Payment
  def retrieve_intent
    Stripe::PaymentIntent.retrieve(transaction.transaction_id)
  end

  # Refund Payment
  def refund_intent
    Stripe::Refund.create(payment_intent: transaction.transaction_id)
  end

  def create_transaction(stripe, option)
    Transaction.create(
      transaction_type: option,
      transaction_id: stripe.id,
      token: stripe.client_secret,
      amount: amount,
      paid_amount: paid_amount,
      bid: instance_obj,
      user: user,
    )
  end

  def update_transaction(stripe)
    return transaction.succeeded! if stripe.status == 'succeeded'

    transaction.failed if stripe.status == 'failed'
  end
end
