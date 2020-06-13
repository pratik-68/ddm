class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :bid

  enum status: { pending: 0, succeeded: 1, failed: 2 }
  enum transaction_type: { refund: 0, paid: 1 }

  validates :amount, presence: true, numericality: {
    greater_than: 0,
    less_than: 100_000_000
  }

  validates :paid_amount, presence: true, numericality: {
    greater_than_or_equal_to: 0,
    less_than: 100_000_000
  }

  validates :token, presence: true
end
