class Loan < ActiveRecord::Base
  belongs_to :borrower, :class_name => "Member", :foreign_key => "borrower_id"
  belongs_to :lender, :class_name => "Member", :foreign_key => "lender_id"
  
  belongs_to :loanable, :polymorphic => :true
  
  def self.period
    self.date_to - self.date_from
  end

#  def check_if_multiple_loan
#  end
end
