class MemberProjectsController < ApplicationController

  # List projects of a member
  def index
	@member = Member.find(params[:member_id])
	@projects = @member.projects_as_leader + @member.projects_as_participant
    render "members/list_projects"
  end
end
