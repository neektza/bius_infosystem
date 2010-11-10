class MemberFieldworksController < ApplicationController
  before_filter :authorize

  # List fieldworks of a member
  def index
	@member = Member.find(params[:member_id])
	@fieldworks = @member.fieldworks_as_leader + @member.fieldworks_as_participant
    render "members/list_fieldworks"
  end
end
