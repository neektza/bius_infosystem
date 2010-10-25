class Loan < ActiveRecord::Base
  belongs_to :borrower, :class_name => "Member", :foreign_key => "borrower_id"
  belongs_to :lender, :class_name => "Member", :foreign_key => "lender_id"
  
  belongs_to :loanable
  
  def self.period
    self.date_to - self.date_from
  end
end
