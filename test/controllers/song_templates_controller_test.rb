require 'test_helper'

class SongTemplatesControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers
  setup do
    @song_template = song_templates(:bigband)
    @librarian = users(:librarian)
    @charles = users(:limited_admin)

    @song_template_params = { name: @song_template.name }
  end

  test 'should not get index when not logged in' do
    get :index
    assert_redirected_to '/'
  end

  test 'should get index without edit buttons when logged in' do
    sign_in @charles
    get :index
    assert_response :success
    objects = assigns(:song_templates)
    assert_not_nil objects
    objects.each do |object|
      assert_select 'a[href=?]', edit_song_template_path(object), count: 0
      assert_select 'a[href=?]', song_template_path(object),
                    text: 'Destroy',
                    count: 0
    end
  end

  test 'should get index with edit buttons when librarian' do
    sign_in @librarian
    get :index
    assert_response :success
    objects = assigns(:song_templates)
    assert_not_nil objects
    objects.each do |object|
      assert_select 'a[href=?]', edit_song_template_path(object)
      assert_select 'a[href=?]', song_template_path(object),
                    text: 'Destroy'
    end
  end

  test 'should not get new as non-librarian' do
    get :new
    assert_redirected_to '/'
    sign_in @charles
    get :new
    assert_redirected_to controller: 'song_templates', action: 'index'
  end

  test 'should get new as librarian' do
    sign_in @librarian
    get :new
    assert_response :success
  end

  test 'should create song_template as librarian' do
    sign_in @librarian
    assert_difference('SongTemplate.count') do
      post :create, song_template: @song_template_params
    end

    assert_redirected_to song_template_path(assigns(:song_template))
  end

  test 'should not create song_template as non-librarian' do
    assert_no_difference 'SongTemplate.count' do
      post :create, song_template: @song_template_params
    end

    sign_in @charles
    assert_no_difference 'SongTemplate.count' do
      post :create, song_template: @song_template_params
    end
  end

  test 'should show song_template as any user' do
    sign_in @charles
    get :show, id: @song_template
    assert_response :success
  end

  test 'should not show song_template when not logged in' do
    get :show, id: @song_template
    assert_redirected_to '/'
  end

  test 'should get edit as librarian' do
    sign_in @librarian
    get :edit, id: @song_template
    assert_response :success
  end

  test 'should not get edit as non-librarian' do
    get :edit, id: @song_template
    assert_redirected_to '/'
    sign_in @charles
    get :edit, id: @song_template
    assert_redirected_to controller: 'song_templates', action: 'index'
  end

  test 'should update song_template as librarian' do
    sign_in @librarian
    @song_template_params[:name] = 'New name'
    patch :update, id: @song_template, song_template: @song_template_params
    assert_redirected_to song_template_path(assigns(:song_template))
    @song_template.reload
    assert_equal 'New name', @song_template.name
  end

  test 'should not update song_template as non-librarian' do
    @song_template_params[:name] = 'New name'
    patch :update, id: @song_template, song_template: @song_template_params
    assert_redirected_to '/'
    @song_template.reload
    assert_not_equal 'New name', @song_template.name
    sign_in @charles
    patch :update, id: @song_template, song_template: @song_template_params
    assert_redirected_to controller: 'song_templates', action: 'index'
    @song_template.reload
    assert_not_equal 'New name', @song_template.name
  end

  test 'should destroy song_template as librarian' do
    sign_in @librarian
    assert_difference('SongTemplate.count', -1) do
      delete :destroy, id: @song_template
    end

    assert_redirected_to song_templates_path
  end

  test 'should not destroy song_template as non-librarian' do
    assert_no_difference 'SongTemplate.count' do
      delete :destroy, id: @song_template
    end

    sign_in @charles
    assert_no_difference 'SongTemplate.count' do
      delete :destroy, id: @song_template
    end
  end
end
