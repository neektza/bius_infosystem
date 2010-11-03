class Member < ActiveRecord::Base
  ROLE = {:admin => '5', :adm_board => '4', :sup_board => '3', :leader => '2', :member => '1', :applicant => '0'}

  has_many :section_memberships, :dependent => :destroy
  has_many :sections, :through => :section_memberships
  has_many :sections_as_leader, :through => :section_memberships, :source => 'section', :conditions => "section_memberships.role = '#{SectionMembership::ROLE[:leader]}'"
  has_many :sections_as_member, :through => :section_memberships, :source => 'section', :conditions => "section_memberships.role = '#{SectionMembership::ROLE[:member]}'"

  has_many :project_participations, :dependent => :destroy
  has_many :projects, :through => :project_participations
  has_many :projects_as_leader, :through => :project_participations, :source => 'project' , :conditions => "project_participations.role = '#{ProjectParticipation::ROLE[:leader]}'"
  has_many :projects_as_participant, :through => :project_participations, :source => 'project' , :conditions => "project_participations.role = '#{ProjectParticipation::ROLE[:participant]}'"
  
  has_many :fieldwork_participations, :dependent => :destroy
  has_many :fieldworks, :through => :fieldwork_participations
  has_many :fieldworks_as_leader, :through => :fieldwork_participations, :source => 'fieldwork' , :conditions => "fieldwork_participations.role = '#{ProjectParticipation::ROLE[:leader]}'"
  has_many :fieldworks_as_participant, :through => :fieldwork_participations, :source => 'fieldwork' , :conditions => "fieldwork_participations.role = '#{ProjectParticipation::ROLE[:participant]}'"
  
  has_many :items_procured, :class_name => "item", :foreign_key => "procurer_id" , :dependent => :nullify
  
  has_many :given_items, :class_name => "Loan", :foreign_key => "lender_id", :dependent => :destroy
  has_many :taken_items, :class_name => "Loan", :foreign_key => "borrower_id", :dependent => :destroy
  has_one :item_in_possesion, :class_name => "itemloan", :foreign_key => "borrower_id", :dependent => :destroy, :conditions => {:date_to => nil}
  
  has_many :transfers , :dependent => :nullify
  
  has_many :membership_fees
  
  has_and_belongs_to_many :tags
  
  validates_presence_of :username
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :hash_pass
  validates_uniqueness_of :username
  validates_confirmation_of :password
  
  def name
    "#{first_name} #{last_name}"
  end

  def self.members
    Member.where(["auth_level >= ?", Member::ROLE[:member]])
  end

  def self.applicants
    Member.where(["auth_level = ?", Member::ROLE[:applicants]])
  end

  def self.check_expiration() 
    @members = Member.all(:conditions => "is_active = TRUE AND active_until IS NOT NULL")
    @members.each do |m|
      if Date.today > m.active_until
        m.is_active = false
        #m.active_until = nil #observer takes care of this
        m.save
      end
    end
  end

  def password
    @password
  end

  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_new_salt
    self.hash_pass = Member.encrypted_password(self.password, self.salt)
  end
 
  private 
  def self.authenticate(username, password)
    user = Member.find_by_username(username)
    if user and user.auth_level.to_i >= ROLE[:member].to_i
      expected_password = encrypted_password(password, user.salt)
      if user.hash_pass != expected_password
        user = nil
      end
    else
      user = nil
    end
    return user
  end
  
  private 
  def self.encrypted_password(password, salt)
    string_to_hash = password + "n00b" + salt
    return Digest::SHA1.hexdigest(string_to_hash)
  end
  
  private 
  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end

end
