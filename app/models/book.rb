class Book < ActiveRecord::Base
  has_many :loans, :as => :loanable, :dependent => :destroy
  belongs_to :procurer, :class_name => "Member", :foreign_key => "procurer_id"
  
  validates_presence_of :author, :title
end
