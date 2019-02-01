require 'test_helper'

class HousesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @house = houses(:one)
  end

  test "should get index" do
    get houses_url
    assert_response :success
  end

  test "should get new" do
    get new_house_url
    assert_response :success
  end

  test "should create house" do
    assert_difference('House.count') do
      post houses_url, params: { house: { bathrooms: @house.bathrooms, bedrooms: @house.bedrooms, floor_area: @house.floor_area, floor_levels: @house.floor_levels, furnishing: @house.furnishing, lease_left: @house.lease_left, location: @house.location, name: @house.name, price: @house.price } }
    end

    assert_redirected_to house_url(House.last)
  end

  test "should show house" do
    get house_url(@house)
    assert_response :success
  end

  test "should get edit" do
    get edit_house_url(@house)
    assert_response :success
  end

  test "should update house" do
    patch house_url(@house), params: { house: { bathrooms: @house.bathrooms, bedrooms: @house.bedrooms, floor_area: @house.floor_area, floor_levels: @house.floor_levels, furnishing: @house.furnishing, lease_left: @house.lease_left, location: @house.location, name: @house.name, price: @house.price } }
    assert_redirected_to house_url(@house)
  end

  test "should destroy house" do
    assert_difference('House.count', -1) do
      delete house_url(@house)
    end

    assert_redirected_to houses_url
  end
end
