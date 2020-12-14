require 'test_helper'

class CrimeInAccusedsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @crime_in_accused = crime_in_accuseds(:one)
  end

  test "should get index" do
    get crime_in_accuseds_url
    assert_response :success
  end

  test "should get new" do
    get new_crime_in_accused_url
    assert_response :success
  end

  test "should create crime_in_accused" do
    assert_difference('CrimeInAccused.count') do
      post crime_in_accuseds_url, params: { crime_in_accused: { crime_id: @crime_in_accused.crime_id, person_id: @crime_in_accused.person_id, preponderant: @crime_in_accused.preponderant, procedure_id: @crime_in_accused.procedure_id } }
    end

    assert_redirected_to crime_in_accused_url(CrimeInAccused.last)
  end

  test "should show crime_in_accused" do
    get crime_in_accused_url(@crime_in_accused)
    assert_response :success
  end

  test "should get edit" do
    get edit_crime_in_accused_url(@crime_in_accused)
    assert_response :success
  end

  test "should update crime_in_accused" do
    patch crime_in_accused_url(@crime_in_accused), params: { crime_in_accused: { crime_id: @crime_in_accused.crime_id, person_id: @crime_in_accused.person_id, preponderant: @crime_in_accused.preponderant, procedure_id: @crime_in_accused.procedure_id } }
    assert_redirected_to crime_in_accused_url(@crime_in_accused)
  end

  test "should destroy crime_in_accused" do
    assert_difference('CrimeInAccused.count', -1) do
      delete crime_in_accused_url(@crime_in_accused)
    end

    assert_redirected_to crime_in_accuseds_url
  end
end
