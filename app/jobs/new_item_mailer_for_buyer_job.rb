class NewItemMailerForBuyerJob < ApplicationJob
  queue_as :default

  def perform(*args)
    UserMailer.item_placed_mail_to_buyer(args).deliver
  end
end
