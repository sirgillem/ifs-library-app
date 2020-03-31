require 'test_helper'

class NavigationTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = 'IFS Library'
  end

  test 'should get root' do
    get root_url
    assert_response :success
    assert_select 'title', "Home | #{@base_title}"
  end

  test 'should get contact' do
    get contact_path
    assert_response :success
    assert_select 'title', "Contact | #{@base_title}"
  end
end
