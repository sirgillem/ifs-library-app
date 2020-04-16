require 'test_helper'

class SongPartsControllerTest < ActionController::TestCase
  setup do
    @song_part = song_parts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:song_parts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create song_part" do
    assert_difference('SongPart.count') do
      post :create, song_part: { name: @song_part.name, notes: @song_part.notes, scanned: @song_part.scanned, song_id: @song_part.song_id, template_id: @song_part.template_id }
    end

    assert_redirected_to song_part_path(assigns(:song_part))
  end

  test "should show song_part" do
    get :show, id: @song_part
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @song_part
    assert_response :success
  end

  test "should update song_part" do
    patch :update, id: @song_part, song_part: { name: @song_part.name, notes: @song_part.notes, scanned: @song_part.scanned, song_id: @song_part.song_id, template_id: @song_part.template_id }
    assert_redirected_to song_part_path(assigns(:song_part))
  end

  test "should destroy song_part" do
    assert_difference('SongPart.count', -1) do
      delete :destroy, id: @song_part
    end

    assert_redirected_to song_parts_path
  end
end
