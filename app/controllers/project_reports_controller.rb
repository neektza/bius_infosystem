class ProjectReportsController < ApplicationController
  before_filter :authorize

  def show
    @project = Project.find(params[:project_id])
    if @project.report.nil?
      flash[:notice] = 'Project has no report.'
    end
  end

  def upload
    @project = Project.find(params[:project_id])
  end

  def create
    @project = Project.find(params[:project_id])
    @project.report = Report.new(:file => params[:report], :year => Time.now.year , :stamp => Time.now)
    if @project.save
      flash.now[:notice] = "Report was successfully saved."
      redirect_to project_report_url(@project)
    end
  end

  def download
    @report = Project.find(params[:project_id]).report
    send_data(@report.data, :filename => @report.filename, :type => @report.content_type)
  end

  def destroy
    @report = Project.find(params[:project_id]).report
    if @report.destroy
      flash[:notice] = 'Report was successfully deleted.'
    end
    redirect_to project_report_url
  end

end
