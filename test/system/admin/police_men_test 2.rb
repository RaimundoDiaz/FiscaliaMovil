require "application_system_test_case"

class Admin::PoliceMenTest < ApplicationSystemTestCase
  setup do
    @admin_police_man = admin_police_men(:one)
  end

  test "visiting the index" do
    visit admin_police_men_url
    assert_selector "h1", text: "Admin/Police Men"
  end

  test "creating a Police man" do
    visit admin_police_men_url
    click_on "New Admin/Police Man"

    click_on "Create Police man"

    assert_text "Police man was successfully created"
    click_on "Back"
  end

  test "updating a Police man" do
    visit admin_police_men_url
    click_on "Edit", match: :first

    click_on "Update Police man"

    assert_text "Police man was successfully updated"
    click_on "Back"
  end

  test "destroying a Police man" do
    visit admin_police_men_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Police man was successfully destroyed"
  end
end
