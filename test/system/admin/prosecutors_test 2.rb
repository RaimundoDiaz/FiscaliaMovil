require "application_system_test_case"

class Admin::ProsecutorsTest < ApplicationSystemTestCase
  setup do
    @admin_prosecutor = admin_prosecutors(:one)
  end

  test "visiting the index" do
    visit admin_prosecutors_url
    assert_selector "h1", text: "Admin/Prosecutors"
  end

  test "creating a Prosecutor" do
    visit admin_prosecutors_url
    click_on "New Admin/Prosecutor"

    click_on "Create Prosecutor"

    assert_text "Prosecutor was successfully created"
    click_on "Back"
  end

  test "updating a Prosecutor" do
    visit admin_prosecutors_url
    click_on "Edit", match: :first

    click_on "Update Prosecutor"

    assert_text "Prosecutor was successfully updated"
    click_on "Back"
  end

  test "destroying a Prosecutor" do
    visit admin_prosecutors_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Prosecutor was successfully destroyed"
  end
end
