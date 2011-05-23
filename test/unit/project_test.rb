require 'test_helper'
 
class ProjectTest < ActiveSupport::TestCase
  test "should not save project without username" do
    m = Project.new
    p.purpose = 'ostvariti boljitak'
    p.year = 1995
    assert !p.save, "Saved member without username"
  end
end
