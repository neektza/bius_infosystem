class ProjectParticipationsController < ApplicationController
  before_filter :authorize

  def index
    #for show_menu
    @project = Project.find(params[:project_id])
    @participations = ProjectParticipation.all(:conditions => {:project_id => params[:project_id], :role => ProjectParticipation::ROLE[:participant]})
    @leaderships = ProjectParticipation.all(:conditions => {:project_id => params[:project_id], :role => ProjectParticipation::ROLE[:leader]})
  end
  
  def registrations
    @project = Project.find(params[:project_id])
    @registrations = ProjectParticipation.all(:conditions => {:project_id => params[:project_id], :role => ProjectParticipation::ROLE[:applicant]})
  end

  def new
    @project = Project.find(params[:project_id])
    @members = Member.all
    if @members.empty?
      flash[:notice] = "No members in database."
    end
  end
  
  def apply
    @membership = ProjectParticipation.new(:project_id => params[:project_id], :member_id => session[:user_id], :role => ProjectParticipation::ROLE[:applicant], :joined => Date.today)
    if @membership.save
      flash[:notice] = "Application successfully submitted."
      redirect_to project_participations_url(params[:project_id])
    end
  end

  def create
    @participation = ProjectParticipation.new(:project_id => params[:project_id], :member_id => params[:id], :role => ProjectParticipation::ROLE[:participant], :joined => Date.today)
    if @participation.save
      flash[:notice] = "Participation successfully created."
      redirect_to project_participations_url(params[:project_id])
    else
      render "new"
    end
  end

  def update
    @participation = ProjectParticipation.find(params[:id])
    if @participation.update_attribute(:role, params[:role])
      flash[:notice] = "Participation successfully updated."
      redirect_to project_participations_url(params[:project_id])
    end
  end

  def destroy
    @participation = ProjectParticipation.find(params[:id])
    if @participation.destroy
      flash[:notice] = "Participation successfully destroyed."
      redirect_to project_participations_url(params[:project_id])
    end
  end
end
