require "application_system_test_case"

class PersonInProceduresTest < ApplicationSystemTestCase
  setup do
    @person_in_procedure = person_in_procedures(:one)
  end

  test "visiting the index" do
    visit person_in_procedures_url
    assert_selector "h1", text: "Person In Procedures"
  end

  test "creating a Person in procedure" do
    visit person_in_procedures_url
    click_on "New Person In Procedure"

    fill_in "Person", with: @person_in_procedure.person_id
    fill_in "Procedure", with: @person_in_procedure.procedure_id
    fill_in "Role", with: @person_in_procedure.role
    click_on "Create Person in procedure"

    assert_text "Person in procedure was successfully created"
    click_on "Back"
  end

  test "updating a Person in procedure" do
    visit person_in_procedures_url
    click_on "Edit", match: :first

    fill_in "Person", with: @person_in_procedure.person_id
    fill_in "Procedure", with: @person_in_procedure.procedure_id
    fill_in "Role", with: @person_in_procedure.role
    click_on "Update Person in procedure"

    assert_text "Person in procedure was successfully updated"
    click_on "Back"
  end

  test "destroying a Person in procedure" do
    visit person_in_procedures_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Person in procedure was successfully destroyed"
  end
end
