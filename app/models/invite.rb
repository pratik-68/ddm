# frozen_string_literal: true

class Invite < ApplicationRecord
  belongs_to :user

  validates :email, presence: true, format: {
    with: Rails.configuration.VALID_EMAIL_REGXP
  }
  validates :status, acceptance: { accept: [0, 1] }

  before_save :downcase_fields

  def downcase_fields
    email.downcase! if email.present?
  end
end
