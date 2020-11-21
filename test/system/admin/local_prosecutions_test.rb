require "application_system_test_case"

class Admin::LocalProsecutionsTest < ApplicationSystemTestCase
  setup do
    @admin_local_prosecution = admin_local_prosecutions(:one)
  end

  test "visiting the index" do
    visit admin_local_prosecutions_url
    assert_selector "h1", text: "Admin/Local Prosecutions"
  end

  test "creating a Local prosecution" do
    visit admin_local_prosecutions_url
    click_on "New Admin/Local Prosecution"

    click_on "Create Local prosecution"

    assert_text "Local prosecution was successfully created"
    click_on "Back"
  end

  test "updating a Local prosecution" do
    visit admin_local_prosecutions_url
    click_on "Edit", match: :first

    click_on "Update Local prosecution"

    assert_text "Local prosecution was successfully updated"
    click_on "Back"
  end

  test "destroying a Local prosecution" do
    visit admin_local_prosecutions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Local prosecution was successfully destroyed"
  end
end
