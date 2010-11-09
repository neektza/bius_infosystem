class FieldworkParticipation < ActiveRecord::Base
  ROLE = {:leader => '2', :participant => '1', :applicant => '0'}

  belongs_to :member
  belongs_to :fieldwork

  validate :id_pair_unique

  private
  def id_pair_unique
    errors[:base] << "#{self.member.username} is already a participant of #{self.fieldwork.title}" unless FieldworkParticipation.all(:conditions => {:member_id => self.member_id, :fieldwork_id => self.fieldwork_id}).blank?
  end
end
