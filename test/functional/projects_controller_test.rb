require 'test_helper'
require 'projects_controller'

class ProjectControllerTest < ActionController::TestCase
  def setup
    @controller = ProjectsController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:projects)
  end
end
