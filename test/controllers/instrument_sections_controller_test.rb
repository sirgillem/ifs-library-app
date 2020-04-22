require 'test_helper'

class InstrumentSectionsControllerTest < ActionController::TestCase
  setup do
    @instrument_section = instrument_sections(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:instrument_sections)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create instrument_section" do
    assert_difference('InstrumentSection.count') do
      post :create, instrument_section: { name: @instrument_section.name, sequence: @instrument_section.sequence }
    end

    assert_redirected_to instrument_section_path(assigns(:instrument_section))
  end

  test "should show instrument_section" do
    get :show, id: @instrument_section
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @instrument_section
    assert_response :success
  end

  test "should update instrument_section" do
    patch :update, id: @instrument_section, instrument_section: { name: @instrument_section.name, sequence: @instrument_section.sequence }
    assert_redirected_to instrument_section_path(assigns(:instrument_section))
  end

  test "should destroy instrument_section" do
    assert_difference('InstrumentSection.count', -1) do
      delete :destroy, id: @instrument_section
    end

    assert_redirected_to instrument_sections_path
  end
end
