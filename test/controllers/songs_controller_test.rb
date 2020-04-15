require 'test_helper'

class SongsControllerTest < ActionController::TestCase
  setup do
    @song = songs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:songs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create song" do
    assert_difference('Song.count') do
      post :create, song: { details: @song.details, duration: @song.duration, label: @song.label, notes_lib: @song.notes_lib, notes_perf: @song.notes_perf, pack_id: @song.pack_id, publisher_id: @song.publisher_id, purchased_at: @song.purchased_at, recording: @song.recording, serial: @song.serial, style: @song.style, tempo: @song.tempo, title: @song.title }
    end

    assert_redirected_to song_path(assigns(:song))
  end

  test "should show song" do
    get :show, id: @song
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @song
    assert_response :success
  end

  test "should update song" do
    patch :update, id: @song, song: { details: @song.details, duration: @song.duration, label: @song.label, notes_lib: @song.notes_lib, notes_perf: @song.notes_perf, pack_id: @song.pack_id, publisher_id: @song.publisher_id, purchased_at: @song.purchased_at, recording: @song.recording, serial: @song.serial, style: @song.style, tempo: @song.tempo, title: @song.title }
    assert_redirected_to song_path(assigns(:song))
  end

  test "should destroy song" do
    assert_difference('Song.count', -1) do
      delete :destroy, id: @song
    end

    assert_redirected_to songs_path
  end
end
