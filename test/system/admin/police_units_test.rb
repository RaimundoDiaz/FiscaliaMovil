require "application_system_test_case"

class Admin::PoliceUnitsTest < ApplicationSystemTestCase
  setup do
    @admin_police_unit = admin_police_units(:one)
  end

  test "visiting the index" do
    visit admin_police_units_url
    assert_selector "h1", text: "Admin/Police Units"
  end

  test "creating a Police unit" do
    visit admin_police_units_url
    click_on "New Admin/Police Unit"

    click_on "Create Police unit"

    assert_text "Police unit was successfully created"
    click_on "Back"
  end

  test "updating a Police unit" do
    visit admin_police_units_url
    click_on "Edit", match: :first

    click_on "Update Police unit"

    assert_text "Police unit was successfully updated"
    click_on "Back"
  end

  test "destroying a Police unit" do
    visit admin_police_units_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Police unit was successfully destroyed"
  end
end
