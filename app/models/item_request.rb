class ItemRequest < ActiveRecord::Base
  belongs_to :item
  belongs_to :requester , :foreign_key => "requester_id" , :class_name =>"Member"
  
  validate :id_pair_must_be_unique
  
  def id_pair_must_be_unique
    errors.add_to_base("#{self.item.name} is already requested.") unless ItemRequest.all(:conditions => {:item_id => self.item_id, :requester_id => self.requester_id}).blank?
  end
  
  class Action
    ASSIGNMENT = 'a'
    DEASSIGNMENT = 'd'
  end
  
end

class BookRequest < ItemRequest
end
