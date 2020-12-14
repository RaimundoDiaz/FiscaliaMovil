require 'test_helper'

class Admin::ProsecutorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_prosecutor = admin_prosecutors(:one)
  end

  test "should get index" do
    get admin_prosecutors_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_prosecutor_url
    assert_response :success
  end

  test "should create admin_prosecutor" do
    assert_difference('Admin::Prosecutor.count') do
      post admin_prosecutors_url, params: { admin_prosecutor: {  } }
    end

    assert_redirected_to admin_prosecutor_url(Admin::Prosecutor.last)
  end

  test "should show admin_prosecutor" do
    get admin_prosecutor_url(@admin_prosecutor)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_prosecutor_url(@admin_prosecutor)
    assert_response :success
  end

  test "should update admin_prosecutor" do
    patch admin_prosecutor_url(@admin_prosecutor), params: { admin_prosecutor: {  } }
    assert_redirected_to admin_prosecutor_url(@admin_prosecutor)
  end

  test "should destroy admin_prosecutor" do
    assert_difference('Admin::Prosecutor.count', -1) do
      delete admin_prosecutor_url(@admin_prosecutor)
    end

    assert_redirected_to admin_prosecutors_url
  end
end
