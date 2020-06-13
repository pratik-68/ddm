# frozen_string_literal: true

class Api::V1::UsersController < ApplicationController
  def show
    success_response(current_user)
  end

  def update
    @user = current_user

    if user_update_params[:password_confirmation].present?
      unless @user.authenticate(user_password_params[:old_password])
        return bad_response(old_password: 'Old Password not match')
      end
    end
    return success_response(@user) if @user.update(user_update_params)

    bad_response(@user.errors)
  end

  private

  def user_update_params
    params.require(:userData).permit(
      :first_name, :last_name, :mobile_number, :address, :password,
      :password_confirmation
    )
  end

  def user_password_params
    return unless params[:password].present?

    params.require(:password).permit(:old_password)
  end
end
