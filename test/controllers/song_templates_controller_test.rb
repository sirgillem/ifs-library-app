require 'test_helper'

class SongTemplatesControllerTest < ActionController::TestCase
  setup do
    @song_template = song_templates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:song_templates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create song_template" do
    assert_difference('SongTemplate.count') do
      post :create, song_template: { name: @song_template.name }
    end

    assert_redirected_to song_template_path(assigns(:song_template))
  end

  test "should show song_template" do
    get :show, id: @song_template
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @song_template
    assert_response :success
  end

  test "should update song_template" do
    patch :update, id: @song_template, song_template: { name: @song_template.name }
    assert_redirected_to song_template_path(assigns(:song_template))
  end

  test "should destroy song_template" do
    assert_difference('SongTemplate.count', -1) do
      delete :destroy, id: @song_template
    end

    assert_redirected_to song_templates_path
  end
end
