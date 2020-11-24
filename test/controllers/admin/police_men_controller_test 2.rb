require 'test_helper'

class Admin::PoliceMenControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_police_man = admin_police_men(:one)
  end

  test "should get index" do
    get admin_police_men_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_police_man_url
    assert_response :success
  end

  test "should create admin_police_man" do
    assert_difference('Admin::PoliceMan.count') do
      post admin_police_men_url, params: { admin_police_man: {  } }
    end

    assert_redirected_to admin_police_man_url(Admin::PoliceMan.last)
  end

  test "should show admin_police_man" do
    get admin_police_man_url(@admin_police_man)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_police_man_url(@admin_police_man)
    assert_response :success
  end

  test "should update admin_police_man" do
    patch admin_police_man_url(@admin_police_man), params: { admin_police_man: {  } }
    assert_redirected_to admin_police_man_url(@admin_police_man)
  end

  test "should destroy admin_police_man" do
    assert_difference('Admin::PoliceMan.count', -1) do
      delete admin_police_man_url(@admin_police_man)
    end

    assert_redirected_to admin_police_men_url
  end
end
