class Item < ActiveRecord::Base
  has_many :loans, :as => :loanable, :dependent => :destroy_all
  belongs_to :procurer, :class_name => "Member", :foreign_key => "procurer_id"
  has_and_belongs_to_many :projects, :join_table => "items_projects"
  has_and_belongs_to_many :fieldworks, :join_table => "items_fieldworks"
 
  validates_presence_of :inventory_number, :name
end


#has_one :active_loan, :class_name => "ItemLoan", :dependent => :destroy, :conditions => {:date_to => nil}
