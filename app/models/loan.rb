class Loan < ActiveRecord::Base
  belongs_to :borrower, :class_name => "Member", :foreign_key => "borrower_id"
  belongs_to :lender, :class_name => "Member", :foreign_key => "lender_id"
  
  belongs_to :loanable, :polymorphic => :true

  #Loan can belong to member or section
  #belongs_to :borrower, :polymorphic => :true

  #validate :loanable_item_or_book
   
  private 
  def loanable_item_or_book
    errors[:base] << "Item/Book already loaned" unless Loan.where(:date_to => nil, :loanable_id => self.loanable_id, :loanable_type => self.loanable_type).empty?
  end
end
