# frozen_string_literal: true

# Verification Model
class Verification < ApplicationRecord
  has_secure_token
  enum status: { inactive: 0, active: 1 }

  # Email for each user must be unique
  validates :email,
            presence: true,
            uniqueness: true,
            format: {
              with: Rails.configuration.VALID_EMAIL_REGXP,
              message: 'Invalid Email address'
            }

  before_validation :downcase_fields
  # after_validation :create_token

  def downcase_fields
    email.downcase! if email.present?
  end

  # def create_token
  #   data = "#{email} #{Time.current}"
  #   self.token = EncryptionService.hash_data(data)
  # end
end
