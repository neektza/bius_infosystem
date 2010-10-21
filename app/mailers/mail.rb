class Mail < ActiveRecord::Base
	belongs_to :sender, :class_name => "Member", :foreign_key => "sender_id"
end
