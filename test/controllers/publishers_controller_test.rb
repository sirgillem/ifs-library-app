require 'test_helper'

class PublishersControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers
  def setup
    @librarian = users(:librarian)
    @limited_admin = users(:limited_admin)
    @user = users(:bob)
  end

  test 'should not get index when not logged in' do
    get :index
    assert_redirected_to '/'
  end

  test 'should get index when logged in' do
    sign_in @user
    get :index
    assert_response :success
    assert_select 'title', text: full_title('All Publishers')
  end

  test 'should not get new as non-librarian' do
    get :new
    assert_redirected_to '/'
    sign_in @limited_admin
    get :new
    assert_redirected_to controller: 'publishers', action: :index
  end

  test 'should get new as librarian' do
    sign_in @librarian
    get :new
    assert_response :success
    assert_select 'title', text: full_title('New Publisher')
  end

  test 'should not create as non-librarian' do
    assert_no_difference 'Publisher.count' do
      post :create, publisher: { name: 'New', website: 'www.example.com' }
    end
    assert_redirected_to '/'
    assert_no_difference 'Publisher.count' do
      post :create, publisher: { name: 'New', website: 'www.example.com' }
    end
    assert_redirected_to '/'
  end

  test 'should create as librarian' do
    sign_in @librarian
    assert_difference 'Publisher.count', 1 do
      post :create, publisher: { name: 'New', website: 'www.example.com' }
    end
  end

  test 'should not get show when not logged in' do
    get :show, id: Publisher.first.id
    assert_redirected_to '/'
  end

  test 'should get show when logged in' do
    pub = Publisher.first
    sign_in @user
    get :show, id: pub.id
    assert_response :success
    assert_select 'title', text: full_title(pub.name)
  end

  test 'should not get edit as non-librarian' do
    pubid = Publisher.first.id
    get :edit, id: pubid
    assert_redirected_to '/'
    sign_in @limited_admin
    get :edit, id: pubid
    assert_redirected_to controller: 'publishers', action: 'show'
  end

  test 'should get edit as librarian' do
    pub = Publisher.first
    sign_in @librarian
    get :edit, id: pub.id
    assert_response :success
    assert_select 'title', text: full_title('Edit publisher')
  end

  test 'should not update as non-librarian' do
    pub = Publisher.first
    name = pub.name
    post :update, id: pub.id, name: 'New name'
    assert_redirected_to '/'
    pub.reload
    assert_equal name, pub.name
    sign_in @limited_admin
    post :update, id: pub.id, name: 'New name'
    assert_redirected_to controller: 'publishers', action: 'index'
    pub.reload
    assert_equal name, pub.name
  end

  test 'should update as librarian' do
    pub = Publisher.first
    name = 'Foobar Inc.'
    website = 'www.foobar.com'
    sign_in @librarian
    post :update, id: pub.id, publisher: { name: name, website: website}
    pub.reload
    assert_equal name, pub.name
    assert_equal website, pub.website
  end

  test 'should not destroy as non-librarian' do
    pub = Publisher.first
    assert_no_difference 'Publisher.count' do
      post :destroy, id: pub.id
    end
    assert_redirected_to '/'

    sign_in @limited_admin
    assert_no_difference 'Publisher.count' do
      post :destroy, id: pub.id
    end
    assert_redirected_to controller: 'publishers', action: 'index'
  end

  test 'should destroy as librarian' do
    sign_in @librarian
    assert_difference 'Publisher.count', -1 do
      post :destroy, id: Publisher.first.id
    end
    assert_redirected_to controller: 'publishers', action: 'index'
  end
end
