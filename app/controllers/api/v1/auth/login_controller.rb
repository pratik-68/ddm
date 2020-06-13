# frozen_string_literal: true

class Api::V1::Auth::LoginController < ApplicationController
  skip_before_action :authorized

  # @return [Object]
  def login
    return bad_response(email: 'Email can\'t be empty') unless login_parameter[:email].present?
    return bad_response(password: 'Password can\'t be empty') unless login_parameter[:password].present?

    @user = User.find_by(email: login_parameter[:email].downcase)
    if @user&.authenticate(login_parameter[:password])
      obj = Token.new(user_id: @user.id)
      if obj.save
        @user.touch(:last_sign_in)
        return success_response(token: obj.token)
      end
      return bad_response(obj.errors)
    end
    bad_response(message: 'Invalid email or password')
  end

  def logout
    token = request.headers[:token]
    return bad_response(token: 'Token can\'t be empty') unless token.present?

    @token = Token.find_by(token: token)
    return success_response({}) if @token.present? && @token.destroy

    bad_response(message: 'Invalid token')
  end

  private

  def login_parameter
    params.require(:user).permit(:email, :password)
  end
end
