require 'test_helper'
require 'members_controller'

class MemberControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  def setup
    @controller = MembersController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
  end

  test "should get index" do
    get :index
    assert_response :redirect
    assert_not_nil assigns(:members)
  end
end
