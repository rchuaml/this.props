class SellerhousesController < ApplicationController
  def show
    @house = House.find(params[:id])
    @buyer = current_user
    UserMailer.new_buyer(@house, @buyer).deliver_now
  end
end