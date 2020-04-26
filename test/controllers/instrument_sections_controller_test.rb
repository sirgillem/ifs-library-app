require 'test_helper'

class InstrumentSectionsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers
  setup do
    @instrument_section = instrument_sections(:sax)
    @librarian = users(:librarian)
    @charles = users(:limited_admin)

    @instrument_section_params = { name: 'Foobar',
                                   sequence: 0 }
  end

  test 'should not get index when not logged in' do
    get :index
    assert_redirected_to '/'
  end

  test 'should get index without edit buttons when logged in' do
    sign_in @charles
    get :index
    assert_response :success
    objects = assigns(:instrument_sections)
    assert_not_nil objects
    objects.each do |object|
      assert_select 'a[href=?]', edit_instrument_section_path(object), count: 0
      assert_select 'a[href=?]', instrument_section_path(object),
                    text: 'Destroy',
                    count: 0
    end
  end

  test 'should get index with edit buttons when librarian' do
    sign_in @librarian
    get :index
    assert_response :success
    objects = assigns(:instrument_sections)
    assert_not_nil objects
    objects.each do |object|
      assert_select 'a[href=?]', edit_instrument_section_path(object)
      assert_select 'a[href=?]', instrument_section_path(object),
                    text: 'Destroy'
    end
  end

  test 'should not get new as non-librarian' do
    get :new
    assert_redirected_to '/'
    sign_in @charles
    get :new
    assert_redirected_to controller: 'instrument_sections', action: 'index'
  end

  test 'should get new as librarian' do
    sign_in @librarian
    get :new
    assert_response :success
  end

  test 'should create instrument_section as librarian' do
    sign_in @librarian
    @instrument_section_params[:name] = 'Ethel'
    assert_difference('InstrumentSection.count') do
      post :create, instrument_section: @instrument_section_params
    end

    assert_redirected_to instrument_section_path(assigns(:instrument_section))
  end

  test 'should not create instrument_section as non-librarian' do
    assert_no_difference 'InstrumentSection.count' do
      post :create, instrument_section: @instrument_section_params
    end

    sign_in @charles
    assert_no_difference 'InstrumentSection.count' do
      post :create, instrument_section: @instrument_section_params
    end
  end

  test 'should show instrument_section as any user' do
    sign_in @charles
    get :show, id: @instrument_section
    assert_response :success
  end

  test 'should not show instrument_section when not logged in' do
    get :show, id: @instrument_section
    assert_redirected_to '/'
  end

  test 'should get edit as librarian' do
    sign_in @librarian
    get :edit, id: @instrument_section
    assert_response :success
  end

  test 'should not get edit as non-librarian' do
    get :edit, id: @instrument_section
    assert_redirected_to '/'
    sign_in @charles
    get :edit, id: @instrument_section
    assert_redirected_to controller: 'instrument_sections', action: 'index'
  end

  test 'should update instrument_section as librarian' do
    sign_in @librarian
    @instrument_section_params[:name] = 'New name'
    patch :update, id: @instrument_section, instrument_section: @instrument_section_params
    assert_redirected_to instrument_section_path(assigns(:instrument_section))
    @instrument_section.reload
    assert_equal 'New name', @instrument_section.name
  end

  test 'should not update instrument_section as non-librarian' do
    @instrument_section_params[:name] = 'New name'
    patch :update, id: @instrument_section, instrument_section: @instrument_section_params
    assert_redirected_to '/'
    @instrument_section.reload
    assert_not_equal 'New name', @instrument_section.name
    sign_in @charles
    patch :update, id: @instrument_section, instrument_section: @instrument_section_params
    assert_redirected_to controller: 'instrument_sections', action: 'index'
    @instrument_section.reload
    assert_not_equal 'New name', @instrument_section.name
  end

  test 'should destroy instrument_section as librarian' do
    sign_in @librarian
    assert_difference('InstrumentSection.count', -1) do
      delete :destroy, id: @instrument_section
    end

    assert_redirected_to instrument_sections_path
  end

  test 'should not destroy instrument_section as non-librarian' do
    assert_no_difference 'InstrumentSection.count' do
      delete :destroy, id: @instrument_section
    end

    sign_in @charles
    assert_no_difference 'InstrumentSection.count' do
      delete :destroy, id: @instrument_section
    end
  end
end
