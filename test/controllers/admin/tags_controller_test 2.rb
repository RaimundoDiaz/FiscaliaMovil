require 'test_helper'

class Admin::TagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_tag = admin_tags(:one)
  end

  test "should get index" do
    get admin_tags_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_tag_url
    assert_response :success
  end

  test "should create admin_tag" do
    assert_difference('Admin::Tag.count') do
      post admin_tags_url, params: { admin_tag: {  } }
    end

    assert_redirected_to admin_tag_url(Admin::Tag.last)
  end

  test "should show admin_tag" do
    get admin_tag_url(@admin_tag)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_tag_url(@admin_tag)
    assert_response :success
  end

  test "should update admin_tag" do
    patch admin_tag_url(@admin_tag), params: { admin_tag: {  } }
    assert_redirected_to admin_tag_url(@admin_tag)
  end

  test "should destroy admin_tag" do
    assert_difference('Admin::Tag.count', -1) do
      delete admin_tag_url(@admin_tag)
    end

    assert_redirected_to admin_tags_url
  end
end
