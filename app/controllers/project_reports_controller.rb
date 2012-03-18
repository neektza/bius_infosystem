class ProjectReportsController < ApplicationController

  def show
    @project = Project.find(params[:project_id])
    if @project.report.nil?
      flash[:notice] = 'Project has no report.'
    end
    authorize! :read, Project
  end

  def new
    @project = Project.find(params[:project_id])
    authorize! :create, Report
  end
  end

  def create
    @project = Project.find(params[:project_id])
    @project.report = Report.new(:document => params[:document], :year => Time.now.year)
    if @project.save
      flash.now[:notice] = "Report was successfully saved."
      redirect_to project_report_url(@project)
    end
    authorize! :create, Report
  end

  def destroy
    @report = Project.find(params[:project_id]).report
    if @report.destroy
      flash[:notice] = 'Report was successfully deleted.'
    end
    redirect_to project_report_url
    authorize! :destroy, Report
  end
  end

end
