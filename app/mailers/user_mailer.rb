class UserMailer < ApplicationMailer
  default :from => '"example" <pranjal@legalsuvidha.com>'

  def signup_confirmation(user)
    @user = user
    mail to: @user.email, subject: 'Sign Up Confirmation'
  end

  def invite_user(args)
    @user = args[0]
    @invited_user = args[1]
    mail to: @invited_user.email, subject: 'Joining Invitation'
  end

  def item_placed_mail_to_buyer(args)
    @buyer = args[0]
    @item = args[1]
    mail to: @buyer.email, subject: 'Item Requested'
  end

  def new_item_request_to_sellers(seller, item)
    @seller = seller
    @item = item
    mail to: @seller.email, subject: 'New Item Request'
  end

  def bidding_start_to_sellers(seller, item)
    @seller = seller
    @item = item
    mail to: @seller.email, subject: "Bidding Start on #{@item.name}"
  end

  def bid_registration_to_seller(args)
    @seller = args[0]
    @item = args[1]
    @bid = args[2]
    mail to: @seller.email, subject: "New Bid register on #{@item.name}"
  end

  def bid_registration_to_buyer(args)
    @item = args[0]
    @buyer = @item.user
    @bid = args[1]
    mail to: @buyer.email, subject: "New Bid register on #{@item.name}"
  end

  def winner_mail_to_buyer(*args)
    @buyer = args[0]
    @item = args[1]
    @bid = args[2]
    mail to: @buyer.email, subject: "Bid winner on #{@item.name}"
  end

  def winner_mail_to_seller(*args)
    @seller = args[0]
    @item = args[1]
    @bid = args[2]
    mail to: @seller.email, subject: "Bid winner on #{@item.name}"
  end
end
