require 'test_helper'

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  test "show action should be success" do
    get :show
    assert_response :success
  end
end
