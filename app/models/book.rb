class Book < ActiveRecord::Base
  has_many :loans, :as => :loanable, :dependent => :destroy_all
  belongs_to :procurer, :class_name => "Member", :foreign_key => "procurer_id"
end
