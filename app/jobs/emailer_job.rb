class EmailerJob < ApplicationJob
  queue_as :default

  # sidekiq_options retry: 5

  def perform(*args)
    UserMailer.signup_confirmation(args[0]).deliver
  end
end
