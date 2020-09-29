require 'test_helper'

class PersonInProceduresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @person_in_procedure = person_in_procedures(:one)
  end

  test "should get index" do
    get person_in_procedures_url
    assert_response :success
  end

  test "should get new" do
    get new_person_in_procedure_url
    assert_response :success
  end

  test "should create person_in_procedure" do
    assert_difference('PersonInProcedure.count') do
      post person_in_procedures_url, params: { person_in_procedure: { person_id: @person_in_procedure.person_id, procedure_id: @person_in_procedure.procedure_id, role: @person_in_procedure.role } }
    end

    assert_redirected_to person_in_procedure_url(PersonInProcedure.last)
  end

  test "should show person_in_procedure" do
    get person_in_procedure_url(@person_in_procedure)
    assert_response :success
  end

  test "should get edit" do
    get edit_person_in_procedure_url(@person_in_procedure)
    assert_response :success
  end

  test "should update person_in_procedure" do
    patch person_in_procedure_url(@person_in_procedure), params: { person_in_procedure: { person_id: @person_in_procedure.person_id, procedure_id: @person_in_procedure.procedure_id, role: @person_in_procedure.role } }
    assert_redirected_to person_in_procedure_url(@person_in_procedure)
  end

  test "should destroy person_in_procedure" do
    assert_difference('PersonInProcedure.count', -1) do
      delete person_in_procedure_url(@person_in_procedure)
    end

    assert_redirected_to person_in_procedures_url
  end
end
