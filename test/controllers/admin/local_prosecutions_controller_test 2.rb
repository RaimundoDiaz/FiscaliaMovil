require 'test_helper'

class Admin::LocalProsecutionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_local_prosecution = admin_local_prosecutions(:one)
  end

  test "should get index" do
    get admin_local_prosecutions_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_local_prosecution_url
    assert_response :success
  end

  test "should create admin_local_prosecution" do
    assert_difference('Admin::LocalProsecution.count') do
      post admin_local_prosecutions_url, params: { admin_local_prosecution: {  } }
    end

    assert_redirected_to admin_local_prosecution_url(Admin::LocalProsecution.last)
  end

  test "should show admin_local_prosecution" do
    get admin_local_prosecution_url(@admin_local_prosecution)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_local_prosecution_url(@admin_local_prosecution)
    assert_response :success
  end

  test "should update admin_local_prosecution" do
    patch admin_local_prosecution_url(@admin_local_prosecution), params: { admin_local_prosecution: {  } }
    assert_redirected_to admin_local_prosecution_url(@admin_local_prosecution)
  end

  test "should destroy admin_local_prosecution" do
    assert_difference('Admin::LocalProsecution.count', -1) do
      delete admin_local_prosecution_url(@admin_local_prosecution)
    end

    assert_redirected_to admin_local_prosecutions_url
  end
end
