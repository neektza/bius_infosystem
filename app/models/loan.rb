class Loan < ActiveRecord::Base
  belongs_to :borrower, :class_name => "Member", :foreign_key => "borrower_id"
  belongs_to :lender, :class_name => "Member", :foreign_key => "lender_id"
  
  belongs_to :loanable, :polymorphic => :true

  #Loan can belong to member or section
  #belongs_to :borrower, :polymorphic => :true
  
#  def check_if_multiple_loan
#  end
end
