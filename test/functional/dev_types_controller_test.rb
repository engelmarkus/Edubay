require 'test_helper'

class DevTypesControllerTest < ActionController::TestCase
  setup do
    @dev_type = dev_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dev_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dev_type" do
    assert_difference('DevType.count') do
      post :create, dev_type: @dev_type.attributes
    end

    assert_redirected_to dev_type_path(assigns(:dev_type))
  end

  test "should show dev_type" do
    get :show, id: @dev_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dev_type
    assert_response :success
  end

  test "should update dev_type" do
    put :update, id: @dev_type, dev_type: @dev_type.attributes
    assert_redirected_to dev_type_path(assigns(:dev_type))
  end

  test "should destroy dev_type" do
    assert_difference('DevType.count', -1) do
      delete :destroy, id: @dev_type
    end

    assert_redirected_to dev_types_path
  end
end
