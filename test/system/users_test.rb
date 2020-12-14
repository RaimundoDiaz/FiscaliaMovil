require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
  end

  test "visiting the index" do
    visit users_url
    assert_selector "h1", text: "Users"
  end

  test "creating a User" do
    visit users_url
    click_on "New User"

    fill_in "Birthday", with: @user.birthday
    fill_in "Local prosecution", with: @user.prosecutor_id
    fill_in "Police unit", with: @user.police_unit_id
    fill_in "Role", with: @user.role
    fill_in "Rut", with: @user.rut
    click_on "Create User"

    assert_text "User was successfully created"
    click_on "Back"
  end

  test "updating a User" do
    visit users_url
    click_on "Edit", match: :first

    fill_in "Birthday", with: @user.birthday
    fill_in "Local prosecution", with: @user.prosecutor_id
    fill_in "Police unit", with: @user.police_unit_id
    fill_in "Role", with: @user.role
    fill_in "Rut", with: @user.rut
    click_on "Update User"

    assert_text "User was successfully updated"
    click_on "Back"
  end

  test "destroying a User" do
    visit users_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User was successfully destroyed"
  end
end
