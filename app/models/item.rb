class Item < ApplicationRecord
  belongs_to :user
  has_many :bids
  has_many :item_descriptions
  has_many :item_groups
  has_many :descriptions, through: :item_descriptions
  has_many :groups, through: :item_groups
  has_many :bids
  has_many :group_buyings

  enum status: { new_item: 0, old_item: 1, second_hand: 2 }
  enum group_buying: { is_not_group_buying: 0, is_group_buying: 1 }

  validates :name, :description, :status, :bidding_end_time, :quantity,
            presence: true
  validates :max_amount, presence: true, numericality: {
    greater_than: 0,
    less_than: 100_000_000
  }
  validates_numericality_of :quantity, greater_than: 0
  validate :valid_end_time

  def valid_end_time
    if bidding_end_time? && bidding_end_time < (Time.current + 1.hours)
      errors.add('bidding_end_time', 'must be greater than 1hr from current time')
    end
  end

  def bidding_start_time
    bidding_end_time - 1.hour
  end

  def buffer_end_time
    bidding_end_time + 15.minutes
  end

  def total_amount
    max_amount * quantity
  end
end
