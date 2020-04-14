require 'test_helper'

class PacksControllerTest < ActionController::TestCase
  setup do
    @pack = packs(:easy_pack_1)
    @librarian = users(:librarian)
    @charles = users(:limited_admin)
  end

  test 'should get index when logged in' do
    sign_in @charles
    get :index
    assert_response :success
    assert_not_nil assigns(:packs)
  end

  test 'should redirect index when not logged in' do
    get :index
    assert_redirected_to '/'
  end

  test 'should get new as librarian' do
    sign_in @librarian
    get :new
    assert_response :success
  end

  test 'should redirect new when not logged in as librarian' do
    get :new
    assert_redirected_to '/'
    sign_in @charles
    get :new
    assert_redirected_to controller: 'packs', action: 'index'
  end

  test 'should create pack as librarian' do
    sign_in @librarian
    assert_difference('Pack.count') do
      post :create, pack: { name: @pack.name, publisher_id: @pack.publisher_id, serial: @pack.serial }
    end

    assert_redirected_to pack_path(assigns(:pack))
  end

  test 'should not create pack as non-librarian' do
    assert_no_difference 'Pack.count' do
      post :create, pack: { name: @pack.name, publisher_id: @pack.publisher_id, serial: @pack.serial }
    end

    sign_in @charles
    assert_no_difference 'Pack.count' do
      post :create, pack: { name: @pack.name, publisher_id: @pack.publisher_id, serial: @pack.serial }
    end
  end

  test 'should show pack as any user' do
    sign_in @charles
    get :show, id: @pack
    assert_response :success
  end

  test 'should redirect show pack when not logged in' do
    get :show, id: @pack
    assert_redirectd_to '/'
  end

  test 'should get edit as librarian' do
    sign_in @librarian
    get :edit, id: @pack
    assert_response :success
  end

  test 'should not get edit as non-librarian' do
    get :edit, id: @pack
    assert_redirected_to '/'
    sign_in @charles
    get :edit, id: @pack
    assert_redirected_to controller: 'packs', action: 'index'
  end

  test 'should update pack as librarian' do
    sign_in @librarian
    patch :update, id: @pack, pack: { name: @pack.name, publisher_id: @pack.publisher_id, serial: @pack.serial }
    assert_redirected_to pack_path(assigns(:pack))
  end

  test 'should not update pack as non-librarian' do
    patch :update, id: @pack, pack: { name: @pack.name, publisher_id: @pack.publisher_id, serial: @pack.serial }
    assert_redirected_to '/'
    sign_in @charles
    patch :update, id: @pack, pack: { name: @pack.name, publisher_id: @pack.publisher_id, serial: @pack.serial }
    assert_redirected_to controller: 'packs', action: 'index'
  end

  test 'should destroy pack as librarian' do
    sign_in @librarian
    assert_difference('Pack.count', -1) do
      delete :destroy, id: @pack
    end

    assert_redirected_to packs_path
  end

  test 'should not destroy pack as non-librarian' do
    assert_no_difference 'Pack.count' do
      delete :destroy, id: @pack
    end
    sign_in @charles
    assert_no_difference 'Pack.count' do
      delete :destroy, id: @pack
    end
  end
end
