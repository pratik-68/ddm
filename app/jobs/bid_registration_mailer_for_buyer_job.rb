class BidRegistrationMailerForBuyerJob < ApplicationJob
  queue_as :default

  def perform(*args)
    UserMailer.bid_registration_to_buyer(args).deliver
  end
end
