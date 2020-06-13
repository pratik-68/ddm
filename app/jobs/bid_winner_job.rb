class BidWinnerJob < ApplicationJob
  queue_as :default

  def perform(*args)
    @bid = Bid.where(item: args[1], status: :pending).minimum(:amount)
    return unless @bid.present?

    @bid.accepted!
    UserMailer.winner_mail_to_buyer(args[0], args[1], @bid)
    UserMailer.winner_mail_to_seller(@bid.user, args[1], @bid)
  end
end
