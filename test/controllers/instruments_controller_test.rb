require 'test_helper'

class InstrumentsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers
  setup do
    @instrument = instruments(:alto_sax)
    @librarian = users(:librarian)
    @charles = users(:limited_admin)

    @instrument_params = { name: 'Foobar',
                           section_id: instrument_sections(:trombone).id }
  end

  test 'should not get index when not logged in' do
    get :index
    assert_redirected_to '/'
  end

  test 'should get index when logged in' do
    sign_in @charles
    get :index
    assert_response :success
    assert_not_nil assigns(:instruments)
  end

  test 'should not get new as non-librarian' do
    get :new
    assert_redirected_to '/'
    sign_in @charles
    get :new
    assert_redirected_to controller: 'instruments', action: 'index'
  end

  test 'should get new as librarian' do
    sign_in @librarian
    get :new
    assert_response :success
  end

  test 'should create instrument as librarian' do
    sign_in @librarian
    @instrument_params[:name] = 'Ethel'
    assert_difference('Instrument.count') do
      post :create, instrument: @instrument_params
    end

    assert_redirected_to instrument_path(assigns(:instrument))
    new = assigns(:instrument)
    assert_equal 'Ethel', new.name
    assert_equal instrument_sections(:trombone).id, new.section_id
  end

  test 'should not create instrument as non-librarian' do
    assert_no_difference 'Instrument.count' do
      post :create, instrument: @instrument_params
    end

    sign_in @charles
    assert_no_difference 'Instrument.count' do
      post :create, instrument: @instrument_params
    end
  end

  test 'should show instrument as any user' do
    sign_in @charles
    get :show, id: @instrument
    assert_response :success
  end

  test 'should not show instrument when not logged in' do
    get :show, id: @instrument
    assert_redirected_to '/'
  end

  test 'should get edit as librarian' do
    sign_in @librarian
    get :edit, id: @instrument
    assert_response :success
  end

  test 'should not get edit as non-librarian' do
    get :edit, id: @instrument
    assert_redirected_to '/'
    sign_in @charles
    get :edit, id: @instrument
    assert_redirected_to controller: 'instruments', action: 'index'
  end

  test 'should update instrument as librarian' do
    sign_in @librarian
    @instrument_params[:name] = 'New name'
    patch :update, id: @instrument, instrument: @instrument_params
    assert_redirected_to instrument_path(assigns(:instrument))
    @instrument.reload
    assert_equal 'New name', @instrument.name
  end

  test 'should not update instrument as non-librarian' do
    @instrument_params[:name] = 'New name'
    patch :update, id: @instrument, instrument: @instrument_params
    assert_redirected_to '/'
    @instrument.reload
    assert_not_equal 'New name', @instrument.name
    sign_in @charles
    patch :update, id: @instrument, instrument: @instrument_params
    assert_redirected_to controller: 'instruments', action: 'index'
    @instrument.reload
    assert_not_equal 'New name', @instrument.name
  end

  test 'should destroy instrument as librarian' do
    sign_in @librarian
    assert_difference('Instrument.count', -1) do
      delete :destroy, id: @instrument
    end

    assert_redirected_to instruments_path
  end

  test 'should not destroy instrument as non-librarian' do
    assert_no_difference 'Instrument.count' do
      delete :destroy, id: @instrument
    end

    sign_in @charles
    assert_no_difference 'Instrument.count' do
      delete :destroy, id: @instrument
    end
  end
end
