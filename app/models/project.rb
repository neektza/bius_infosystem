class Project < ActiveRecord::Base
  has_many :project_participations, :dependent => :destroy
  has_many :members, :through => :project_participations
  has_many :leaders, :through => :project_participations, :source => 'member' , :conditions => "project_participations.role = 'leader'"
  has_many :participants, :through => :project_participations, :source => 'member' , :conditions => "project_participations.role = 'participant'"
  has_one :report, :as => :reportable, :dependent => :delete
  has_and_belongs_to_many :items, :join_table => "items_projects"

  validates_presence_of :title
end
