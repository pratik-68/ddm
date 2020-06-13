# frozen_string_literal: true

class User < ApplicationRecord
  # https://github.com/rails/rails/blob/f33d52c95217212cbacc8d5e44b5a8e3cdc6f5b3/activemodel/lib/active_model/secure_password.rb#L61
  has_secure_password

  has_many :tokens
  has_many :group_users
  has_many :groups, through: :group_users
  has_many :items
  has_many :invites
  has_many :bids
  has_many :transactions
  has_many :group_buyings
  has_many :bid_likes

  enum type_of_user: { buyer: 0, seller: 1, both: 2 }

  validates :first_name, :last_name, :mobile_number, :address, :email,
            :password_digest, :type_of_user, presence: true

  # Email for each user must be unique
  validates :email,
            uniqueness: true,
            format: {
              with: Rails.configuration.VALID_EMAIL_REGXP,
              message: 'Invalid Email address'
            }

  # Mobile number for each user must be unique
  validates :mobile_number,
            uniqueness: true,
            format: {
              with: Rails.configuration.VALID_MOBILE_NUMBER_REGXP,
              message: 'Invalid Mobile Number'
            }

  validates :password, length: { minimum: 8, maximum: 20 }, if: :password

  validates :invite_count,
            numericality: {
              greater_than_or_equal_to: 0,
              less_than_or_equal_to: 25
            },
            if: :invite_count

  # validates :type_of_user,
  #           inclusion: {
  #             in: %w(buyer seller both),
  #             message: "%{value} is not a valid type of user"
  #           }

  before_validation :downcase_fields

  def downcase_fields
    email.downcase! if email.present?
  end
end
