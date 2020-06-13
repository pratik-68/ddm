class GroupBuying < ApplicationRecord
  belongs_to :user
  belongs_to :item

  validates :quantity, presence: true, numericality: { greater_than: 0 }
end
