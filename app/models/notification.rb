class Notification < ActiveRecord::Base
	has_and_belongs_to_many :tags
	validates_presence_of :title
	validates_presence_of :body
end
