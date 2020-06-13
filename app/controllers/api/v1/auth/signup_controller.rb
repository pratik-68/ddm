# frozen_string_literal: true

class Api::V1::Auth::SignupController < ApplicationController
  skip_before_action :authorized

  # @return [JSON]
  def index
    @verification = Verification.find_by(token: params.fetch(:token))
    return bad_response(token: 'Invalid Token') unless @verification.present?
    return bad_response(email: 'Email already active') if @verification.active?

    success_response(email: @verification.email)
  end

  # @return [JSON]
  def create
    @verification = Verification.find_by(token: params.fetch(:token))
    return bad_response(token: 'Invalid Token') unless @verification.present?
    return bad_response(email: 'Email already active') if @verification.active?

    @user = User.new(signup_params)
    @user.email = @verification.email
    if @user.save
      @verification.active!
      return create_response({})
    end
    bad_response(@user.errors)
  end

  private

  def signup_params
    params.require(:user).permit(
      :first_name, :last_name, :mobile_number, :address, :type_of_user,
      :password, :password_confirmation
    )
  end
end
