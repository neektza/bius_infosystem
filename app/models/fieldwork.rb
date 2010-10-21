class Fieldwork < ActiveRecord::Base
  has_many :fieldwork_participations, :dependent => :destroy
  has_many :members, :through => :fieldwork_participations
  has_many :leaders, :through => :fieldwork_participations, :source => 'member' , :conditions => "fieldwork_participations.role = 'leader'"
  has_many :participants, :through => :fieldwork_participations, :source => 'member' , :conditions => "fieldwork_participations.role = 'participant'"
  has_one :report, :as => :reportable, :dependent => :delete
  has_and_belongs_to_many :items, :join_table => "items_fieldworks"

  validates_presence_of :location

  def validate
    unless self.start_date <= self.end_date
      errors.add("Duration")
    end
  end
  
  def duration
    return (self.end_date - self.start_date + 1)
  end
end
