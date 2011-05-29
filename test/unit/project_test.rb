require 'test_helper'
 
class ProjectTest < ActiveSupport::TestCase
  test "should not save project without title" do
    p = Project.new(:purpose => 'Ostvariti boljitak!', :year => 1995)
    assert !p.save, "Saved project without title"
  end
end
