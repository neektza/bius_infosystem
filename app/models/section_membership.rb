class SectionMembership < ActiveRecord::Base
  ROLE = {:leader => '2', :member => '1', :applicant => '0'}
 
  belongs_to :member
  belongs_to :section

  validate :id_pair_must_unique

  private
  def id_pair_must_unique
    errors.add_to_base("#{self.member.username} is already a member of #{self.section.title}") unless SectionMembership.all(:conditions => {:member_id => self.member_id, :section_id => self.section_id}).blank?
  end
end
