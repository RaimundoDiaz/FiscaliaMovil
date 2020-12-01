require 'test_helper'

class OperatorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @operator = operators(:one)
  end

  test "should get index" do
    get operators_url
    assert_response :success
  end

  test "should get new" do
    get new_operator_url
    assert_response :success
  end

  test "should create operator" do
    assert_difference('Operator.count') do
      post operators_url, params: { operator: {  } }
    end

    assert_redirected_to operator_url(Operator.last)
  end

  test "should show operator" do
    get operator_url(@operator)
    assert_response :success
  end

  test "should get edit" do
    get edit_operator_url(@operator)
    assert_response :success
  end

  test "should update operator" do
    patch operator_url(@operator), params: { operator: {  } }
    assert_redirected_to operator_url(@operator)
  end

  test "should destroy operator" do
    assert_difference('Operator.count', -1) do
      delete operator_url(@operator)
    end

    assert_redirected_to operators_url
  end
end
