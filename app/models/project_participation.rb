class ProjectParticipation < ActiveRecord::Base
  ROLE = {:leader => '2', :participant => '1', :applicant => '0'}

  belongs_to :member
  belongs_to :project

  validate :id_pair_unique

  private
  def id_pair_unique
    errors[:base] << "#{self.member.username} is already a participant of #{self.project.title}" unless ProjectParticipation.all(:conditions => {:member_id => self.member_id, :project_id => self.project_id}).blank?
  end
end
