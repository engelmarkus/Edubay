require 'test_helper'

class DocTypesControllerTest < ActionController::TestCase
  setup do
    @doc_type = doc_types(:doc_type1)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:doc_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create doc_type" do
    assert_difference('DocType.count') do
      post :create, doc_type: @doc_type.attributes
    end

    assert_redirected_to doc_type_path(assigns(:doc_type))
  end

  test "should show doc_type" do
    get :show, id: @doc_type.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @doc_type.to_param
    assert_response :success
  end

  test "should update doc_type" do
    put :update, id: @doc_type.to_param, doc_type: @doc_type.attributes
    assert_redirected_to doc_type_path(assigns(:doc_type))
  end

  test "should destroy doc_type" do
    assert_difference('DocType.count', -1) do
      delete :destroy, id: @doc_type.to_param
    end

    assert_redirected_to doc_types_path
  end
end
