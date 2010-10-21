class MemberSectionsController < ApplicationController

  # List sections of a member
  def index
	@member = Member.find(params[:member_id])
	@sections = @member.sections_as_leader + @member.sections_as_member
    render "members/list_sections"
  end
end
