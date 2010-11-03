class MembershipFee < ActiveRecord::Base
  belongs_to :member
  validates_uniqueness_of :year
end
