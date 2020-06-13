class Api::V1::InvitesController < ApplicationController
  def create
    email = invite_params[:email]
    return bad_response(email: 'can\'t be blank') unless email.present?

    # Max Invite Per day count 25
    current_user.invite_count = 0 if current_user.last_invite_at != Date.current
    if current_user.invite_count >= 25
      return bad_response(message: 'Invite Limit Exceeds')
    end

    email = email.downcase
    @user = Verification.find_by(email: email)
    if @user.present? && @user.active?
      return bad_response(email: 'Email already active')
    end

    @invite = Invite.find_by(email: email)
    if @invite.present?
      @invite.update(user: current_user)
    else
      @invite = Invite.new(email: email, user: current_user)
    end
    @user = Verification.create(email: email) unless @user.present?

    if @user.present? && @invite.save
      @user.touch
      InvitationMailerJob.perform_later(current_user, @user)
      current_user.increment!(:invite_count)
      current_user.touch(:last_invite_at)
      return create_response({})
    end
    bad_response(@invite.errors)
  end

  private

  def invite_params
    params.require(:invite).permit(:email)
  end
end
