require 'test_helper'

class UserActionsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @admin = users(:admin)
    @user = users(:bob)
    ActionMailer::Base.deliveries.clear
  end

  test 'can log in' do
    get new_user_session_path
    assert_response :success
    assert_template 'devise/sessions/new/'
    sign_in @user
    assert_response :success
    get root_url
    assert_select 'a[href=?]', edit_user_registration_path
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
      'user[email]' => 'new_user@new_user.com'
    }
    get new_user_invitation_path
    assert_response :success
    assert_difference 'User.count', 1 do
      post user_invitation_path, params
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    sign_out @user
    # User needs to set a password
    new_user = assigns(:user)
    assert_not new_user.invitation_accepted_at

    # TODO: test user setting password pages
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

  test 'can reset password' do
    get new_user_password_path
    assert_response :success
    # TODO: test resetting of password
  end
end
