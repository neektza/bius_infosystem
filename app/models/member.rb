class Member < ActiveRecord::Base
  ROLES = %w[admin section_leader grunt]

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name

  has_many :section_memberships, :dependent => :destroy
  has_many :sections, :through => :section_memberships
  has_many :sections_as_leader, :through => :section_memberships, :source => 'section', 
  :conditions => ["section_memberships.role = ?", SectionMembership::ROLE[:leader]]
  has_many :sections_as_member, :through => :section_memberships, :source => 'section', 
  :conditions => ["section_memberships.role = ?", SectionMembership::ROLE[:member]]

  has_many :project_participations, :dependent => :destroy
  has_many :projects, :through => :project_participations
  has_many :projects_as_leader, :through => :project_participations, :source => 'project',
  :conditions => ["project_participations.role = ?", ProjectParticipation::ROLE[:leader]]
  has_many :projects_as_participant, :through => :project_participations, :source => 'project',
  :conditions => ["project_participations.role = ?", ProjectParticipation::ROLE[:participants]]
  
  has_many :fieldwork_participations, :dependent => :destroy
  has_many :fieldworks, :through => :fieldwork_participations
  has_many :fieldworks_as_leader, :through => :fieldwork_participations, :source => 'fieldwork', :conditions => ["fieldwork_participations.role = ?", FieldworkParticipation::ROLE[:leader]]
  has_many :fieldworks_as_participant, :through => :fieldwork_participations, :source => 'fieldwork', :conditions => ["fieldwork_participations.role = ?", FieldworkParticipation::ROLE[:participants]]
  
  has_many :items_procured, :class_name => "Item", :foreign_key => "procurer_id" , :dependent => :nullify
  
  
  has_many :transfers , :dependent => :nullify
  
  has_many :membership_fees
  
  has_and_belongs_to_many :tags
  
  def name
    "#{first_name} #{last_name}"
  end

  def admin?
    role == "admin"
  end

  def section_leader?
    role == "section_leader"
  end

  def grunt?
    role == "grunt"
  end
  
  # runs as periodic task
  def self.check_expiration() 
    @members = Member.all(:conditions => ["is_active = ? AND active_until IS NOT NULL", true])
    @members.each do |m|
      if Date.today > m.active_until
        m.is_active = false
        #m.active_until = nil #observer takes care of this
        m.save
      end
    end
  end

end
