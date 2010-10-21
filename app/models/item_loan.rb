class ItemLoan < ActiveRecord::Base
  belongs_to :taker, :foreign_key => "taker_id", :class_name => "Member"
  belongs_to :giver, :foreign_key => "giver_id", :class_name => "Member"
  belongs_to :item
  
  def self.period
    self.date_to - self.date_from
  end
end

class BookLoan < ItemLoan
end
