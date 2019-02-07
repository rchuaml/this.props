require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "new_buyer" do
    mail = UserMailer.new_buyer
    assert_equal "New buyer", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
