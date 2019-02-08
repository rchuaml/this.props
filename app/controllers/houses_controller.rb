class HousesController < ApplicationController
  # before_action :set_house, only: [:index]

  # Before login, a user can only see index page
  before_action :authenticate_user!, :except => [:index ]

  # GET /houses
  # GET /houses.json
  def index
    @houses = House.all
    gon.houses = @houses
  end

  # GET /houses/1
  # GET /houses/1.json

  def button
    @house = House.find(params[:id])
    @buyer = current_user
    UserMailer.new_buyer(@house, @buyer).deliver_now
        respond_to do |format|
    format.html { redirect_to show_path(@house.id), notice: 'Email has been successfully sent to the seller of house. Please wait for the seller to contact you via email if they are keen.' }
  end
  end

  def show
    @house = House.find(params[:id])
  end

  # GET /houses/new
  def new
    @house = House.new
  end

  # GET /houses/1/edit
  def edit
  end

  # POST /houses
  # POST /houses.json
  def create
    @house = House.new(house_params)
    @house.user = current_user

    respond_to do |format|
      if @house.save
        format.html { redirect_to root_path, notice: 'House was successfully created.' }
        format.json { render :show, status: :created, location: @house }
      else
        format.html { render :new }
        format.json { render json: @house.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /houses/1
  # PATCH/PUT /houses/1.json
  def update
    respond_to do |format|
      if @house.update(house_params)
        format.html { redirect_to @house, notice: 'House was successfully updated.' }
        format.json { render :show, status: :ok, location: @house }
      else
        format.html { render :edit }
        format.json { render json: @house.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /houses/1
  # DELETE /houses/1.json
  def destroy
    @house.destroy
    respond_to do |format|
      format.html { redirect_to houses_url, notice: 'House was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_house
      @house = House.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def house_params
      params.require(:house).permit(:name, :location, :lat, :long, :price, :bedrooms, :bathrooms, :floor_area, :furnishing, :floor_levels, :lease_left, :images => [])
    end
end