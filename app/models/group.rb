class Group < ApplicationRecord
  has_one_attached :logo
  has_many :group_users
  has_many :users, through: :group_users
  has_many :item_groups
  has_many :items, through: :item_groups

  validates :name, :description, presence: true
  validate :correct_logo

  def correct_logo
    errors.add(logo: 'must be present') unless logo.attached?

    unless logo.content_type.in?(%w(image/jpeg image/png image/jpg))
      errors.add(logo: 'invalid image type')
    end
  end
end
