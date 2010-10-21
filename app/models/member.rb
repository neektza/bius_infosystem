class Member < ActiveRecord::Base
 
  # FIXME change to auth level 
  ROLE = {:admin => '5', :adm_board => '4', :sup_board => '3', :leader => '2', :member => '1', :applicant => '0'}

  AUTH_LEVEL = {:admin => '5', :adm_board => '4', :sup_board => '3', :leader => '2', :member => '1', :applicant => '0'}
  
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
  
  has_many :items , :foreign_key => "procurer_id" , :dependent => :nullify
  has_many :item_requests , :foreign_key => "requester_id" ,:dependent => :destroy
  
  has_many :transfers , :dependent => :nullify
  
#  has_many :items_requested , :through => :item_requests, :source => :item , :dependent => :destroy
#  has_many :items_taken , :class_name => "ItemLoan" , :finder_sql => "select il.* from item_loans il where il.taker_id = #{self.id} and il.date_to is not null"
#  has_many :items_given , :class_name => "ItemLoan" , :finder_sql => "select il.* from item_loans il where il.giver_id = #{self.id}"
#  has_many :items_in_possession, :class_name => "ItemLoan" , :finder_sql => "select il.* from item_loans il where il.taker_id = #{self.id} and il.date_to is null"

  has_many :mails, :foreign_key => "sender_id"

  has_many :fees, :source => 'membership_fee'
  
  has_and_belongs_to_many :tags
  
  validates_presence_of :username
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :hash_pass
  validates_uniqueness_of :username
  validates_confirmation_of :password 

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
