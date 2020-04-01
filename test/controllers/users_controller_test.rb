require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers
  def setup
    @admin = users(:admin)
    @bob = users(:bob)
  end
  
  test "should not get index as user or not logged in" do
    get :index
    assert_redirected_to '/'
    sign_in @bob
    get :index
    assert_redirected_to '/'
  end

  test 'should get index as admin' do
    sign_in @admin
    get :index
    assert_response :success
  end

  test "should not get show as user or not logged in" do
    get :show, id: 1
    assert_redirected_to '/'
    sign_in @bob
    get :show, id: 1
    assert_redirected_to '/'
  end

  test "should get show as admin" do
    sign_in @admin
    get :show, id: 1
    assert_response :success
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      post :destroy, id: @admin.id
    end
    assert_redirected_to root_url
  end

  test "should redirect destroy when logged in as non-admin" do
    sign_in @bob
    assert_no_difference 'User.count' do
      post :destroy, id: @admin.id
    end
    assert_redirected_to root_url
  end

  test "should destroy as admin" do
    sign_in @admin
    assert_difference 'User.count', -1 do
      post :destroy, id: @bob.id
    end
    assert_redirected_to users_url
  end

end
