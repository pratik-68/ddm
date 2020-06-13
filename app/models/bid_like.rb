class BidLike < ApplicationRecord
  belongs_to :user
  belongs_to :bid

  enum like: { not_liked: 0, liked: 1 }
end
