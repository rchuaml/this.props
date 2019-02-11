class MessagesController < ApplicationController

  def index
    queryString = "user1 = " + current_user.id.to_s
    @sellerbuyers = BuyerSeller.where (queryString)
    # user2 = User.find(@sellerbuyer[0][:user2])
    # house = @sellerbuyer[0].house
  end

  def show
    @sellerbuyer = BuyerSeller.find(params[:sellerbuyer_id])
    user1 = @sellerbuyer[:user1]
    user2 = @sellerbuyer[:user2]
    house = @sellerbuyer.house
    @messages = []
    message1 = ChatboxMessage.where(messenger: user1, receiver: user2, house: house)
    message2 = ChatboxMessage.where(messenger: user2, receiver: user1, house: house)
    for i in (0...message1.length) do
      @messages.push(message1[i])
    end
    for j in (message1.length...message1.length+message2.length) do
      @messages.push(message2[j-message1.length])
    end
    @messages.sort! { |a,b| a.created_at <=> b.created_at }

    # render plain:@sellerbuyer.id.inspect
  end

  def new
  # render plain: params[:house_id].inspect
  end

  def create
    message = message_params[:message]
    sellerbuyer_id = params[:sellerbuyer_id].to_i
    buyerseller = BuyerSeller.find(sellerbuyer_id)
    user2 = buyerseller.user2
    house =  buyerseller.house
    message = ChatboxMessage.new(messenger: current_user.id, receiver: user2, message: message, house: house)
    message.save

    redirect_to message_path(sellerbuyer_id)
  end


  def createfirst
    house = House.find(params[:house_id].to_i)

    sellerbuyer1 = BuyerSeller.new(user1: current_user.id, user2: house.user_id, house: house)
    sellerbuyer1.save

    sellerbuyer2 = BuyerSeller.new(user1: house.user_id, user2: current_user.id, house: house)
    sellerbuyer2.save

    message = ChatboxMessage.new(messenger: current_user.id, receiver: house.user_id, message: message_params[:message], house: house)
    message.save

    redirect_to message_path(sellerbuyer1.id)
  end

  private
  def message_params
    params.require(:chatbox_message).permit(:message)
  end

end