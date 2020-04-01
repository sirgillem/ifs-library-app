require 'test_helper'

class UserActionsTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  def setup
    @admin = users(:admin)
    @user = users(:bob)
  end

  test "can edit own information" do
    sign_in users(:bob)
    patch user_registration_path, 'user[email]' => 'me@me.net', 'user[current_password]' => 'password'
    @user.reload
    assert_equal 'me@me.net', @user.email
  end

  test "should not allow roles to be edited via the web" do
    sign_in @user
    assert_not @user.admin?
    assert_not @user.librarian?
    params = {
      'user[email]' => 'me@me.net', 
      'user[current_password]' => 'password',
      'user[admin]' => true,
      'user[librarian]' => true
    }
    patch user_registration_path, params
    @user.reload
    assert_equal 'me@me.net', @user.email
    assert_not @user.admin?
    assert_not @user.librarian?
  end

  test "user cannot edit other user" do
    assert false, "Fix me when admin interface built"
  end

  test "admin can edit other user" do
    assert false, 'Fix me when admin interface built'
  end

end
