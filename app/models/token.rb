# frozen_string_literal: true

# Token Model
class Token < ApplicationRecord
  has_secure_token
  belongs_to :user

  before_validation :set_last_used_on

  def set_last_used_on
    self.last_used_on = Time.current
  end
end
