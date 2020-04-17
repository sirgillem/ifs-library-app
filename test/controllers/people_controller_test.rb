require 'test_helper'

class PeopleControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers
  setup do
    @person = people(:complexname)
    @librarian = users(:librarian)
    @charles = users(:limited_admin)

    @person_params = { pre_titles: @person.pre_titles,
                       pre_names: @person.pre_names,
                       key_name_prefix: @person.key_name_prefix,
                       key_name: @person.key_name,
                       post_names: @person.post_names,
                       key_name_suffix: @person.key_name_suffix,
                       qualifications: @person.qualifications,
                       post_titles: @person.post_titles }
  end

  test 'should not get index when not logged in' do
    get :index
    assert_redirected_to '/'
  end

  test 'should get index when logged in' do
    sign_in @charles
    get :index
    assert_response :success
    assert_not_nil assigns(:people)
  end

  test 'should not get new as non-librarian' do
    get :new
    assert_redirected_to '/'
    sign_in @charles
    get :new
    assert_redirected_to controller: 'people', action: 'index'
  end

  test 'should get new as librarian' do
    sign_in @librarian
    get :new
    assert_response :success
  end

  test 'should create person as librarian' do
    sign_in @librarian
    @person_params[:pre_names] = 'Ethel'
    assert_difference('Person.count') do
      post :create, person: @person_params
    end

    assert_redirected_to person_path(assigns(:person))
  end

  test 'should not create person as non-librarian' do
    assert_no_difference 'Person.count' do
      post :create, person: @person_params
    end

    sign_in @charles
    assert_no_difference 'Person.count' do
      post :create, person: @person_params
    end
  end

  test 'should show person as any user' do
    sign_in @charles
    get :show, id: @person
    assert_response :success
  end

  test 'should not show person when not logged in' do
    get :show, id: @person
    assert_redirected_to '/'
  end

  test 'should get edit as librarian' do
    sign_in @librarian
    get :edit, id: @person
    assert_response :success
  end

  test 'should not get edit as non-librarian' do
    get :edit, id: @person
    assert_redirected_to '/'
    sign_in @charles
    get :edit, id: @person
    assert_redirected_to controller: 'people', action: 'index'
  end

  test 'should update person as librarian' do
    sign_in @librarian
    @person_params[:key_name] = 'New name'
    patch :update, id: @person, person: @person_params
    assert_redirected_to person_path(assigns(:person))
    @person.reload
    assert_equal 'New name', @person.key_name
  end

  test 'should not update person as non-librarian' do
    @person_params[:key_name] = 'New name'
    patch :update, id: @person, person: @person_params
    assert_redirected_to '/'
    @person.reload
    assert_not_equal 'New name', @person.key_name
    sign_in @charles
    patch :update, id: @person, person: @person_params
    assert_redirected_to controller: 'people', action: 'index'
    @person.reload
    assert_not_equal 'New name', @person.key_name
  end

  test 'should destroy person as librarian' do
    sign_in @librarian
    assert_difference('Person.count', -1) do
      delete :destroy, id: @person
    end

    assert_redirected_to people_path
  end

  test 'should not destroy person as non-librarian' do
    assert_no_difference 'Person.count' do
      delete :destroy, id: @person
    end

    sign_in @charles
    assert_no_difference 'Person.count' do
      delete :destroy, id: @person
    end
  end
end
