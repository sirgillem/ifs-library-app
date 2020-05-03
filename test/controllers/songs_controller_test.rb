require 'test_helper'

class SongsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers
  setup do
    @song = songs(:opus_one)
    @librarian = users(:librarian)
    @charles = users(:limited_admin)

    @song_params = { details: @song.details,
                     duration: @song.duration,
                     label: @song.label,
                     notes_lib: @song.notes_lib,
                     notes_perf: @song.notes_perf,
                     pack: @song.pack,
                     publisher: @song.publisher,
                     purchased_at: @song.purchased_at,
                     recording: @song.recording,
                     serial: @song.serial,
                     style: @song.style,
                     tempo: @song.tempo,
                     title: @song.title }
  end

  test 'should not get index when not logged in' do
    get :index
    assert_redirected_to '/'
  end

  test 'should get index without edit buttons when logged in' do
    sign_in @charles
    get :index
    assert_response :success
    objects = assigns(:songs)
    assert_not_nil objects
    objects.each do |object|
      assert_select 'a[href=?]', edit_song_path(object), count: 0
      assert_select 'a[href=?]', song_path(object),
                    text: 'Destroy',
                    count: 0
    end
  end

  test 'should get index with edit buttons when librarian' do
    sign_in @librarian
    get :index
    assert_response :success
    objects = assigns(:songs)
    assert_not_nil objects
    objects.each do |object|
      assert_select 'a[href=?]', edit_song_path(object)
      assert_select 'a[href=?]', song_path(object),
                    text: 'Destroy'
    end
  end

  test 'should not get new as non-librarian' do
    get :new
    assert_redirected_to '/'
    sign_in @charles
    get :new
    assert_redirected_to controller: 'songs', action: 'index'
  end

  test 'should get new as librarian' do
    sign_in @librarian
    get :new
    assert_response :success
    # Check blank template_id
    get :new, template_id: ''
    assert_response :success
  end

  test 'new from template should initialise parts' do
    sign_in @librarian
    template = song_templates(:bigband)
    get :new, template_id: template.id
    assert_response :success
    new_song = assigns(:song)
    i = 0
    assert_equal template.song_parts.count, new_song.song_parts.size
    template.song_parts.each do |part|
      new_part = new_song.song_parts[i]
      assert_equal new_part.name, part.name
      part.instruments.each do |instrument|
        assert new_part.instruments.include?(instrument)
      end
      i += 1
    end
  end

  test 'should create song as librarian' do
    sign_in @librarian
    assert_difference('Song.count') do
      post :create, song: @song_params
    end

    assert_redirected_to song_path(assigns(:song))
  end

  test 'should not create song as non-librarian' do
    assert_no_difference 'Song.count' do
      post :create, song: @song_params
    end

    sign_in @charles
    assert_no_difference 'Song.count' do
      post :create, song: @song_params
    end
  end

  test 'should create song with no duration' do
    sign_in @librarian
    @song_params[:duration] = ''
    assert_difference 'Song.count' do
      post :create, song: @song_params
    end
  end

  test 'should show song as any user' do
    sign_in @charles
    get :show, id: @song
    assert_response :success
  end

  test 'should not show song when not logged in' do
    get :show, id: @song
    assert_redirected_to '/'
  end

  test 'should get edit as librarian' do
    sign_in @librarian
    get :edit, id: @song
    assert_response :success
  end

  test 'should not get edit as non-librarian' do
    get :edit, id: @song
    assert_redirected_to '/'
    sign_in @charles
    get :edit, id: @song
    assert_redirected_to controller: 'songs', action: 'index'
  end

  test 'should update song as librarian' do
    sign_in @librarian
    @song_params[:title] = 'New title'
    patch :update, id: @song, song: @song_params
    assert_redirected_to song_path(assigns(:song))
    @song.reload
    assert_equal 'New title', @song.title
  end

  test 'should not update song as non-librarian' do
    @song_params[:title] = 'New title'
    patch :update, id: @song, song: @song_params
    assert_redirected_to '/'
    @song.reload
    assert_not_equal 'New title', @song.title
    sign_in @charles
    patch :update, id: @song, song: @song_params
    assert_redirected_to controller: 'songs', action: 'index'
    @song.reload
    assert_not_equal 'New title', @song.title
  end

  test 'update should be able to use a formatted time string' do
    sign_in @librarian
    @song_params[:duration] = '123'
    patch :update, id: @song, song: @song_params
    @song.reload
    assert_equal 123, @song.duration

    @song_params[:duration] = '9:04'
    patch :update, id: @song, song: @song_params
    @song.reload
    assert_equal 9 * 60 + 4, @song.duration

    @song_params[:duration] = '01:1:9'
    patch :update, id: @song, song: @song_params
    @song.reload
    assert_equal 3600 + 60 + 9, @song.duration
  end

  test 'should destroy song as librarian' do
    sign_in @librarian
    assert_difference('Song.count', -1) do
      delete :destroy, id: @song
    end

    assert_redirected_to songs_path
  end

  test 'should not destroy song as non-librarian' do
    assert_no_difference 'Song.count' do
      delete :destroy, id: @song
    end

    sign_in @charles
    assert_no_difference 'Song.count' do
      delete :destroy, id: @song
    end
  end

  test 'should not get catalogue when not logged in' do
    get :catalogue
    assert_redirected_to root_path
  end

  test 'should get catalogue when logged in' do
    sign_in @charles
    get :catalogue
    assert_response :success
    assert_equal Song.filter_by_label(true).count, assigns(:songs).count
  end
end
