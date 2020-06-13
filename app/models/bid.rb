# frozen_string_literal: true

# Bid Model
class Bid < ApplicationRecord
  default_scope -> { where(deleted_at: nil) }

  belongs_to :user
  belongs_to :item
  has_many :bid_descriptions
  has_many :descriptions, through: :bid_descriptions
  has_many_attached :images
  has_many :transactions
  has_many :bid_likes

  enum status: { pending: 0, rejected: 1, accepted: 2 }

  validates :name, presence: true
  validates :amount, presence: true, numericality: {
    greater_than: 0,
    less_than: 100_000_000
  }

  before_validation :validate_biding_time
  before_validation :validate_amount

  def validate_biding_time
    if Time.current >= item.bidding_end_time
      errors.add('bidding_end_time', 'Bidding Time over')
    end
  end

  def validate_amount
    if amount.present? && amount > item.total_amount
      errors.add('amount', 'Amount can\'t be grater than Item amount')
    end
  end

  def bid_reject
    rejected! if bid_refund
  end

  def soft_delete
    update(deleted_at: Time.current) if bid_refund
  end

  def bid_refund
    return true
    transactions.find_each do |transaction|
      BidRefundJob.perform_now(transaction, user) if transaction.succeeded?
    end
  end
end
