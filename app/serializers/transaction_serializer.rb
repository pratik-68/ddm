class TransactionSerializer < ApplicationSerializer
  attributes :transaction_id, :transaction_type, :amount, :paid_amount,
             :created_at

  attribute :status

  def status
    return :SUCCESS if object.succeeded?
    return :PENDING if object.pending?

    :FAIL if object.failed?
  end
end
