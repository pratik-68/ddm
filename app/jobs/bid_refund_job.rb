class BidRefundJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # TODO: update Refund job


  end
end
