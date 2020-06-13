# frozen_string_literal: true

class Api::V1::Auth::EmailVerificationController < ApplicationController
  skip_before_action :authorized

  # @return [JSON]
  def email_verification
    email = email_params[:email]
    return bad_response(email: 'Email can\'t be empty') unless email.present?

    @verification = Verification.find_by(email: email.downcase)
    if @verification.present? && @verification.active?
      return bad_response(email: 'Email already active')
    end

    @verification = Verification.new(email_params) unless @verification.present?
    if @verification.save
      EmailerJob.perform_later(@verification)
      return create_response({})
    end
    bad_response(@verification.errors)
  end

  private

  def email_params
    params.require(:user).permit(:email)
  end
end
