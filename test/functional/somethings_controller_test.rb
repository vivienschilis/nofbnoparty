require 'test_helper'

class SomethingsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:somethings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create something" do
    assert_difference('Something.count') do
      post :create, :something => { }
    end

    assert_redirected_to something_path(assigns(:something))
  end

  test "should show something" do
    get :show, :id => somethings(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => somethings(:one).to_param
    assert_response :success
  end

  test "should update something" do
    put :update, :id => somethings(:one).to_param, :something => { }
    assert_redirected_to something_path(assigns(:something))
  end

  test "should destroy something" do
    assert_difference('Something.count', -1) do
      delete :destroy, :id => somethings(:one).to_param
    end

    assert_redirected_to somethings_path
  end
end
