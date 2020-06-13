class NewItemMailerForSellerJob < ApplicationJob
  queue_as :default

  def perform(*args)
    @sellers = User.where.not(type_of_user: :buyer, email: args[0].email)
    @sellers.each do |seller|
      UserMailer.new_item_request_to_sellers(seller, args[1]).deliver
    end
  end
end
