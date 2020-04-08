require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers
  def setup
    @admin = users(:admin)
    @bob = users(:bob)
  end

  test 'should not get index as user or not logged in' do
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
    User.all.each do |user|
      # should have edit links for all users
      assert_select 'a[href=?]', user_path(user), text: 'details'
      # should have delete links for all users except self
      if user != @admin
        assert_select 'a[href=?]', user_path(user), text: 'delete'
      else
        assert_select 'a[href=?]', user_path(user), count: 0, text: 'delete'
      end
    end
    # can invite users
    assert_select 'a[href=?]', new_user_invitation_path
  end

  test 'should not get show as user or not logged in' do
    get :show, id: @bob.id
    assert_redirected_to '/'
    sign_in @bob
    get :show, id: @bob.id
    assert_redirected_to '/'
  end

  test 'should get show as admin' do
    sign_in @admin
    get :show, id: @bob.id
    assert_response :success
    assert_match @bob.email, @response.body
  end

  test 'should get appropriate details in show' do
    sign_in @admin
    get :show, id: @admin.id
    assert_response :success
    assert_select 'li', text: 'Admin'
    assert_select 'li', text: 'Librarian'
    assert_select 'a[href=?]', edit_user_path(@admin)
    assert_select 'a[href=?]', user_path(@admin), text: 'delete', count: 0

    get :show, id: @bob.id
    assert_response :success
    assert_select 'li', text: 'Admin', count: 0
    assert_select 'li', text: 'Librarian', count: 0
    assert_select 'a[href=?]', edit_user_path(@bob)
    assert_select 'a[href=?]', user_path(@bob), text: 'delete'
  end

  test 'should redirect destroy when not logged in' do
    assert_no_difference 'User.count' do
      post :destroy, id: @admin.id
    end
    assert_redirected_to root_url
  end

  test 'should redirect destroy when logged in as non-admin' do
    sign_in @bob
    assert_no_difference 'User.count' do
      post :destroy, id: @admin.id
    end
    assert_redirected_to root_url
  end

  test 'should destroy as admin' do
    sign_in @admin
    assert_difference 'User.count', -1 do
      post :destroy, id: @bob.id
    end
    assert_redirected_to users_url
  end

  test 'cannot edit as non-admin' do
    sign_in @bob
    get :edit, id: @admin.id
    assert_redirected_to '/'
    patch :update, id: @bob.id, user: { email: 'new@email.com',
                                        admin: true,
                                        librarian: true }
    assert_redirected_to '/'
    @bob.reload
    assert_not @bob.admin?
    assert_not @bob.librarian?
  end

  test 'unsuccessful admin edit' do
    sign_in @admin
    get :edit, id: @admin.id
    assert_template 'users/edit'
    patch :update, id: @admin.id, user: { email: 'invalid' }
    assert_template 'users/edit'
    assert_select 'div#error_explanation', /.*1 error.*/
  end

  test 'successful admin edit' do
    sign_in @admin
    get :edit, id: @bob.id
    assert_template 'users/edit'
    email = 'new@email.com'
    assert_not @bob.admin?
    assert_not @bob.librarian?
    patch :update, id: @bob.id, user: { email: email,
                                        admin: true,
                                        librarian: true }
    assert_not flash.empty?
    assert_redirected_to @bob
    @bob.reload
    assert_equal email, @bob.email
    assert @bob.admin?
    assert @bob.librarian?
  end
end
