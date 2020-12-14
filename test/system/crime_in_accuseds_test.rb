require "application_system_test_case"

class CrimeInAccusedsTest < ApplicationSystemTestCase
  setup do
    @crime_in_accused = crime_in_accuseds(:one)
  end

  test "visiting the index" do
    visit crime_in_accuseds_url
    assert_selector "h1", text: "Crime In Accuseds"
  end

  test "creating a Crime in accused" do
    visit crime_in_accuseds_url
    click_on "New Crime In Accused"

    fill_in "Crime", with: @crime_in_accused.crime_id
    fill_in "Person", with: @crime_in_accused.person_id
    check "Preponderant" if @crime_in_accused.preponderant
    fill_in "Procedure", with: @crime_in_accused.procedure_id
    click_on "Create Crime in accused"

    assert_text "Crime in accused was successfully created"
    click_on "Back"
  end

  test "updating a Crime in accused" do
    visit crime_in_accuseds_url
    click_on "Edit", match: :first

    fill_in "Crime", with: @crime_in_accused.crime_id
    fill_in "Person", with: @crime_in_accused.person_id
    check "Preponderant" if @crime_in_accused.preponderant
    fill_in "Procedure", with: @crime_in_accused.procedure_id
    click_on "Update Crime in accused"

    assert_text "Crime in accused was successfully updated"
    click_on "Back"
  end

  test "destroying a Crime in accused" do
    visit crime_in_accuseds_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Crime in accused was successfully destroyed"
  end
end
