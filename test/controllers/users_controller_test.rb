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

  test "should not get new as user or not logged in" do
    get :new
    assert_redirected_to '/'
    sign_in @bob
    get :new
    assert_redirected_to '/'
  end

  test "should get new as admin" do
    sign_in @admin
    get :new
    assert_response :success
  end

end
