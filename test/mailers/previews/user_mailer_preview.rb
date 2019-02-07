# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/new_buyer
  def new_buyer
    house = House.find(2)
    buyer = User.find(1)
    UserMailer.new_buyer(house, buyer)
  end

end