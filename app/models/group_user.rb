class GroupUser < ApplicationRecord
  belongs_to :group
  belongs_to :user

  validates :user_type, presence: true

  enum user_type: { leave: 0, owner: 1, admin: 2, normal_user: 3 }
end
