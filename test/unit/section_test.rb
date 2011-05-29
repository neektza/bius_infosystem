require 'test_helper'
 
class SectionTest < ActiveSupport::TestCase
  test "should not save member without title" do
    s = Section.new(:work_plan => 'Biti l33t h4xori')
    assert !s.save, "Saved section without title"
  end
end
