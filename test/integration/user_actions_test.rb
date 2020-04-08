require 'test_helper'

class UserActionsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @admin = users(:admin)
    @user = users(:bob)
    ActionMailer::Base.deliveries.clear
  end

  test 'can edit own information' do
    sign_in users(:bob)
    patch user_registration_path, 'user[email]' => 'me@me.net',
                                  'user[current_password]' => 'password'
    @user.reload
    assert_equal 'me@me.net', @user.email
  end

  test 'should not allow roles to be edited via the web' do
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

  test 'should not invite user when not logged in' do
    params = {
      'user[email]' => 'foo@bar.web',
      'user[password]' => 'password',
      'user[password_confirmation]' => 'password'
    }
    assert_no_difference 'User.count' do
      post user_invitation_path, params
    end
    assert_redirected_to new_user_session_path
  end

  test 'should invite user when logged in' do
    sign_in @user
    params = {
      'user[email]' => 'foo@bar.web',
      'user[password]' => 'password',
      'user[password_confirmation]' => 'password'
    }
    assert_difference 'User.count', 1 do
      post user_invitation_path, params
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    # User can sign in
    new_user = assigns(:user)
    sign_in new_user
    get root_url
    assert_select 'a[href=?]', edit_user_registration_path
  end

  test 'only create users through invitations' do
    assert_raise NameError do
      get new_user_registration_path
    end
    params = {
      'user[email]' => 'foo@bar.web',
      'user[password]' => 'password',
      'user[password_confirmation]' => 'password'
    }
    assert_raise ActionController::RoutingError do
      post user_registration_path, params
    end
  end
end
