require "application_system_test_case"

class PlacesTest < ApplicationSystemTestCase
  setup do
    @place = places(:one)
  end

  test "visiting the index" do
    visit places_url
    assert_selector "h1", text: "Places"
  end

  test "should create place" do
    visit places_url
    click_on "New place"

    fill_in "Address", with: @place.address
    fill_in "City", with: @place.city
    fill_in "District", with: @place.district
    fill_in "Name", with: @place.name
    fill_in "Phone", with: @place.phone
    fill_in "Uf", with: @place.uf
    fill_in "Website", with: @place.website
    click_on "Create Place"

    assert_text "Place was successfully created"
    click_on "Back"
  end

  test "should update Place" do
    visit place_url(@place)
    click_on "Edit this place", match: :first

    fill_in "Address", with: @place.address
    fill_in "City", with: @place.city
    fill_in "District", with: @place.district
    fill_in "Name", with: @place.name
    fill_in "Phone", with: @place.phone
    fill_in "Uf", with: @place.uf
    fill_in "Website", with: @place.website
    click_on "Update Place"

    assert_text "Place was successfully updated"
    click_on "Back"
  end

  test "should destroy Place" do
    visit place_url(@place)
    click_on "Destroy this place", match: :first

    assert_text "Place was successfully destroyed"
  end
end
