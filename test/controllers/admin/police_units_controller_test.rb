require 'test_helper'

class Admin::PoliceUnitsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_police_unit = admin_police_units(:one)
  end

  test "should get index" do
    get admin_police_units_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_police_unit_url
    assert_response :success
  end

  test "should create admin_police_unit" do
    assert_difference('Admin::PoliceUnit.count') do
      post admin_police_units_url, params: { admin_police_unit: {  } }
    end

    assert_redirected_to admin_police_unit_url(Admin::PoliceUnit.last)
  end

  test "should show admin_police_unit" do
    get admin_police_unit_url(@admin_police_unit)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_police_unit_url(@admin_police_unit)
    assert_response :success
  end

  test "should update admin_police_unit" do
    patch admin_police_unit_url(@admin_police_unit), params: { admin_police_unit: {  } }
    assert_redirected_to admin_police_unit_url(@admin_police_unit)
  end

  test "should destroy admin_police_unit" do
    assert_difference('Admin::PoliceUnit.count', -1) do
      delete admin_police_unit_url(@admin_police_unit)
    end

    assert_redirected_to admin_police_units_url
  end
end
