require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @admin = users(:admin)
    @user = users(:bob)
  end

  test 'layout links' do
    get root_path
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', root_path, count: 2
    assert_select 'a[href=?]', contact_path
    assert_select 'a[href=?]', 'https://www.infullswing.org.au'
    assert_select 'a[href=?]', new_user_session_path
  end

  test 'links for admin user' do
    sign_in @admin
    get root_path
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', root_path, count: 2
    assert_select 'a[href=?]', contact_path
    assert_select 'a[href=?]', 'https://www.infullswing.org.au'
    assert_select 'a[href=?]', destroy_user_session_path
    assert_select 'a[href=?]', edit_user_registration_path
    assert_select 'a[href=?]', users_path
  end

  test 'links for non-admin user' do
    sign_in @user
    get root_path
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', root_path, count: 2
    assert_select 'a[href=?]', contact_path
    assert_select 'a[href=?]', 'https://www.infullswing.org.au'
    assert_select 'a[href=?]', destroy_user_session_path
    assert_select 'a[href=?]', edit_user_registration_path
    assert_select 'a[href=?]', users_path, count: 0
  end
end
