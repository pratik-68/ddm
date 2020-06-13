class BidRegistrationMailerForSellerJob < ApplicationJob
  queue_as :default

  def perform(*args)
    UserMailer.bid_registration_to_seller(args).deliver
  end
end
