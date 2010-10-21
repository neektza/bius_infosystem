class ProjectsController < ApplicationController
  before_filter :authorize
  before_filter :check_if_project_leader, :only => [:edit, :update]
  before_filter :check_if_administrative_board, :only => [:new, :create, :destroy]

  def index
	@projects = Project.all
	if @projects.empty?
	  flash[:notice] = "No projects in database."
	end
	respond_to do |format|
	  format.html
	  format.xml { render :xml => @projects.to_xml }
	end
  end

  def search
	@projects = []
	if params[:keyword]
	  @projects = Project.all(:conditions => ["title LIKE ?" , "%#{params[:keyword]}%"])
	  if @projects.empty?
		flash[:notice] = "No such projects in database."
	  end
	end
  end

  def show
	@project = Project.find(params[:id])
	respond_to do |format|
	  format.html # index.rhtml
	  format.xml { render :xml => @project.to_xml }
	end
  end

  def new
	@project = Project.new
  end

  def edit
	@project = Project.find(params[:id])
  end

  def create
	@project = Project.new(params[:project])
	if @project.save
	  flash[:notice] = "Project was successfully created."
	  redirect_to projects_url
	else
	  render "new"
	end
  end

  def update
	@project = Project.find(params[:id])
	if @project.update_attributes(params[:project])
	  flash[:notice] = "Project was successfully updated."
	  redirect_to project_url(@project)
	else
	  render "edit"
	end
  end

  def destroy
	@project = Project.find(params[:id])
	if @project.destroy
	  flash[:notice] = "Project was successfully deleted."
	  redirect_to :action => 'index'
	end
  end

  def list
	@member = Member.find(params[:member_id])
	@projects = @member.projects_as_leader + @member.projects_as_participant
  end

end
