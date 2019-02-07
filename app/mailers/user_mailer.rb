class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.new_buyer.subject
  #
  def new_buyer (house, buyer)
    @house = house
    @buyer = buyer

    mail to: @house.user.email, subject: "New Buyer for #{@house.name}, #{@house.location}"
  end
end