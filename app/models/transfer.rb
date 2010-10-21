class Transfer < ActiveRecord::Base
  # TYPE to avoid STI
  TYPE = {:incoming => 'i', :outgoing => 'o'}

  belongs_to :member
  
  validates_presence_of :in_out
  validates_presence_of :amount
  validates_numericality_of :amount
end
