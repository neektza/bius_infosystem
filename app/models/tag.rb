class Tag < ActiveRecord::Base
  validates_uniqueness_of :title
  
  has_and_belongs_to_many :notifications
  has_and_belongs_to_many :members
end
