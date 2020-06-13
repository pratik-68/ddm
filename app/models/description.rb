class Description < ApplicationRecord
  has_many :item_descriptions
  has_many :items, through: :item_descriptions
  has_many :bid_descriptions
  has_many :bids, through: :bid_descriptions

  validates :label, :detail, presence: true
  before_validation :downcase_fields

  def downcase_fields
    label.downcase! if label.present?
    detail.downcase! if detail.present?
  end
end
