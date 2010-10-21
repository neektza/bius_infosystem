class Transfer < ActiveRecord::Base

  class IO #to avoid STI
    INCOMING = "incoming"
    OUTGOING = "outgoing"
  end

  belongs_to :member
  validates_numericality_of :amount
end
