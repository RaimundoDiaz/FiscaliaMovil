require "application_system_test_case"

class AliasAccusedsTest < ApplicationSystemTestCase
  setup do
    @alias_accused = alias_accuseds(:one)
  end

  test "visiting the index" do
    visit alias_accuseds_url
    assert_selector "h1", text: "Alias Accuseds"
  end

  test "creating a Alias accused" do
    visit alias_accuseds_url
    click_on "New Alias Accused"

    fill_in "Alias", with: @alias_accused.alias
    fill_in "Person", with: @alias_accused.person_id
    click_on "Create Alias accused"

    assert_text "Alias accused was successfully created"
    click_on "Back"
  end

  test "updating a Alias accused" do
    visit alias_accuseds_url
    click_on "Edit", match: :first

    fill_in "Alias", with: @alias_accused.alias
    fill_in "Person", with: @alias_accused.person_id
    click_on "Update Alias accused"

    assert_text "Alias accused was successfully updated"
    click_on "Back"
  end

  test "destroying a Alias accused" do
    visit alias_accuseds_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Alias accused was successfully destroyed"
  end
end
