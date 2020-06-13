require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  # test "signup_confirmation" do
  # mail = UserMailer.signup_confirmation
  # assert_equal "Signup confirmation", mail.subject
  # assert_equal ["to@example.org"], mail.to
  # assert_equal ["from@example.com"], mail.from
  # assert_match "Hi", mail.body.encoded
  # end

  test "signup_confirmation" do
    # # Create the email and store it for further assertions
    # email = UserMailer.signup_confirmation('pranjal0819@gmail.com')
    #
    # # Send the email, then test that it got queued
    # assert_emails 1 do
    #   email.deliver_now
    # end
    #
    # # Test the body of the sent email contains what we expect it to
    # assert_equal ['me@example.com'], email.from
    # assert_equal ['pranjal0819@gmail.com'], email.to
    # assert_equal 'Sign Up Confirmation', email.subject
  end

end
