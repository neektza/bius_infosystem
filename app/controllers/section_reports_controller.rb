class SectionReportsController < ApplicationController

  def index
    @section = Section.find(params[:section_id])
    @reports = @section.reports.sort { |a,b| a.year <=> b.year }
    if @section.reports.empty?
      flash[:notice] = 'Section has no reports.'
    end
    authorize! :read, Section 
  end

  def new
    @section = Section.find(params[:section_id])
    authorize! :create, Report
  end

  def create
    @section = Section.find(params[:section_id])
    @section.reports << Report.new(:document => params[:document], :year => params[:date][:year])
    if @section.save
      flash.now[:notice] = "Report was successfully saved."
      redirect_to section_reports_url(@section)
    else
      render "new"
    end
    authorize! :create, Report
  end

  def destroy
    @report = Report.find(params[:id])
    if @report.destroy
      flash[:notice] = 'Report was successfully deleted.'
    end
    redirect_to section_reports_url
    authorize! :destroy, Report
  end

end
