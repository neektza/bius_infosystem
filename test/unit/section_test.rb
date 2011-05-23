require 'test_helper'
 
class SectionTest < ActiveSupport::TestCase

  # nemos comp spremit bez naziva
  test "should not save member without title" do
    s = Section.new
    s.work_plan = 'biti l33t h4xori'
    assert !m.save, "Saved section without title"
  end
end
