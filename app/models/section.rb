class Section < ActiveRecord::Base
  has_many :section_memberships, :dependent => :destroy
  has_many :members, :through => :section_memberships, :conditions => "section_memberships.role = 'member'"
  has_many :leaders, :through => :section_memberships, :source => 'member' , :conditions => "section_memberships.role = 'leader'"
  has_many :reports, :as => :reportable, :dependent => :delete_all

  validates_presence_of :title
end
