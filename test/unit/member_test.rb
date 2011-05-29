require 'test_helper'
 
class MemberTest < ActiveSupport::TestCase
  test "should not save member without username" do
    m = Member.new(:first_name => 'Nikica', :last_name => 'Jokic', :hash_pass => 'blabla123')
    assert !m.save, "Saved member without username"
  end

  test "should not save member without hash_pass" do
    m = Member.new(:username => 'neektza', :first_name => 'Nikica', :last_name => 'Jokic')
	  assert !m.save, "Saved member without hash_pass"
  end

  test "should not save member without first_name" do
    m = Member.new(:username => 'neektza', :last_name => 'Jokic', :hash_pass => 'blabla123')
	  assert !m.save, "Saved member without first_name"
  end

  test "should not save member without last_name" do
    m = Member.new(:username => 'neektza', :first_name => 'Nikica', :hash_pass => 'blabla123')
	  assert !m.save, "Saved member without last_name"
  end

  # member with username neektza already present (as fixture)
  test "should not save member with non uniqe username" do
    m = Member.new(:username => 'neektza', :first_name => 'Nikica', :last_name => 'Jokic', :hash_pass => 'blabla123')
	  assert !m.save, "Saved non unique username"
  end

  test "expiration" do
    m = Member.new
  end

end
