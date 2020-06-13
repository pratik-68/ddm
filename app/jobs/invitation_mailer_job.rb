class InvitationMailerJob < ApplicationJob
  queue_as :default

  def perform(*args)
    UserMailer.invite_user(args).deliver
  end
end
