require 'test_helper'

class SongPartsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers
  setup do
    @song_part = song_parts(:opus_one_tenor1)
    @librarian = users(:librarian)
    @charles = users(:limited_admin)

    @song_part_params = { name: @song_part.name,
                          scanned: @song_part.scanned,
                          notes: @song_part.notes,
                          song_id: @song_part.id }
  end

  test 'should not get index when not logged in' do
    get :index
    assert_redirected_to '/'
  end

  test 'should get index when logged in' do
    sign_in @charles
    get :index
    assert_response :success
    assert_not_nil assigns(:song_parts)
  end

  test 'should not get new as non-librarian' do
    get :new
    assert_redirected_to '/'
    sign_in @charles
    get :new
    assert_redirected_to controller: 'song_parts', action: 'index'
  end

  test 'should get new as librarian' do
    sign_in @librarian
    get :new
    assert_response :success
  end

  test 'should create song_part as librarian' do
    sign_in @librarian
    assert_difference('SongPart.count') do
      post :create, song_part: @song_part_params
    end

    assert_redirected_to song_part_path(assigns(:song_part))
  end

  test 'should not create song_part as non-librarian' do
    assert_no_difference 'SongPart.count' do
      post :create, song_part: @song_part_params
    end

    sign_in @charles
    assert_no_difference 'SongPart.count' do
      post :create, song_part: @song_part_params
    end
  end

  test 'should show song_part as any user' do
    sign_in @charles
    get :show, id: @song_part
    assert_response :success
  end

  test 'should not show song_part when not logged in' do
    get :show, id: @song_part
    assert_redirected_to '/'
  end

  test 'should get edit as librarian' do
    sign_in @librarian
    get :edit, id: @song_part
    assert_response :success
  end

  test 'should not get edit as non-librarian' do
    get :edit, id: @song_part
    assert_redirected_to '/'
    sign_in @charles
    get :edit, id: @song_part
    assert_redirected_to controller: 'song_parts', action: 'index'
  end

  test 'should update song_part as librarian' do
    sign_in @librarian
    @song_part_params[:name] = 'New name'
    patch :update, id: @song_part, song_part: @song_part_params
    assert_redirected_to song_part_path(assigns(:song_part))
    @song_part.reload
    assert_equal 'New name', @song_part.name
  end

  test 'should not update song_part as non-librarian' do
    @song_part_params[:name] = 'New name'
    patch :update, id: @song_part, song_part: @song_part_params
    assert_redirected_to '/'
    @song_part.reload
    assert_not_equal 'New name', @song_part.name
    sign_in @charles
    patch :update, id: @song_part, song_part: @song_part_params
    assert_redirected_to controller: 'song_parts', action: 'index'
    @song_part.reload
    assert_not_equal 'New name', @song_part.name
  end

  test 'should destroy song_part as librarian' do
    sign_in @librarian
    assert_difference('SongPart.count', -1) do
      delete :destroy, id: @song_part
    end

    assert_redirected_to song_parts_path
  end

  test 'should not destroy song_part as non-librarian' do
    assert_no_difference 'SongPart.count' do
      delete :destroy, id: @song_part
    end

    sign_in @charles
    assert_no_difference 'SongPart.count' do
      delete :destroy, id: @song_part
    end
  end
end
