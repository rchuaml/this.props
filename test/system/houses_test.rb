require "application_system_test_case"

class HousesTest < ApplicationSystemTestCase
  setup do
    @house = houses(:one)
  end

  test "visiting the index" do
    visit houses_url
    assert_selector "h1", text: "Houses"
  end

  test "creating a House" do
    visit houses_url
    click_on "New House"

    fill_in "Bathrooms", with: @house.bathrooms
    fill_in "Bedrooms", with: @house.bedrooms
    fill_in "Floor area", with: @house.floor_area
    fill_in "Floor levels", with: @house.floor_levels
    fill_in "Furnishing", with: @house.furnishing
    fill_in "Lease left", with: @house.lease_left
    fill_in "Location", with: @house.location
    fill_in "Name", with: @house.name
    fill_in "Price", with: @house.price
    click_on "Create House"

    assert_text "House was successfully created"
    click_on "Back"
  end

  test "updating a House" do
    visit houses_url
    click_on "Edit", match: :first

    fill_in "Bathrooms", with: @house.bathrooms
    fill_in "Bedrooms", with: @house.bedrooms
    fill_in "Floor area", with: @house.floor_area
    fill_in "Floor levels", with: @house.floor_levels
    fill_in "Furnishing", with: @house.furnishing
    fill_in "Lease left", with: @house.lease_left
    fill_in "Location", with: @house.location
    fill_in "Name", with: @house.name
    fill_in "Price", with: @house.price
    click_on "Update House"

    assert_text "House was successfully updated"
    click_on "Back"
  end

  test "destroying a House" do
    visit houses_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "House was successfully destroyed"
  end
end
