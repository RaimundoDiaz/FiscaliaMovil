require 'test_helper'

class AliasAccusedsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @alias_accused = alias_accuseds(:one)
  end

  test "should get index" do
    get alias_accuseds_url
    assert_response :success
  end

  test "should get new" do
    get new_alias_accused_url
    assert_response :success
  end

  test "should create alias_accused" do
    assert_difference('AliasAccused.count') do
      post alias_accuseds_url, params: { alias_accused: { alias: @alias_accused.alias, person_id: @alias_accused.person_id } }
    end

    assert_redirected_to alias_accused_url(AliasAccused.last)
  end

  test "should show alias_accused" do
    get alias_accused_url(@alias_accused)
    assert_response :success
  end

  test "should get edit" do
    get edit_alias_accused_url(@alias_accused)
    assert_response :success
  end

  test "should update alias_accused" do
    patch alias_accused_url(@alias_accused), params: { alias_accused: { alias: @alias_accused.alias, person_id: @alias_accused.person_id } }
    assert_redirected_to alias_accused_url(@alias_accused)
  end

  test "should destroy alias_accused" do
    assert_difference('AliasAccused.count', -1) do
      delete alias_accused_url(@alias_accused)
    end

    assert_redirected_to alias_accuseds_url
  end
end
