require 'test_helper'

class AsamMastersControllerTest < ActionController::TestCase
  setup do
    @asam_master = asam_masters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:asam_masters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create asam_master" do
    assert_difference('AsamMaster.count') do
      post :create, asam_master: {  }
    end

    assert_redirected_to asam_master_path(assigns(:asam_master))
  end

  test "should show asam_master" do
    get :show, id: @asam_master
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @asam_master
    assert_response :success
  end

  test "should update asam_master" do
    patch :update, id: @asam_master, asam_master: {  }
    assert_redirected_to asam_master_path(assigns(:asam_master))
  end

  test "should destroy asam_master" do
    assert_difference('AsamMaster.count', -1) do
      delete :destroy, id: @asam_master
    end

    assert_redirected_to asam_masters_path
  end
end
