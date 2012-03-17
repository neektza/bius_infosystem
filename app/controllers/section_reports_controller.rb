class SectionReportsController < ApplicationController

  def index
    @section = Section.find(params[:section_id])
    #@reports = @section.section_reports(:order => 'year')
    @reports = @section.reports.sort { |a,b| a.year <=> b.year }
    if @section.reports.empty?
      flash[:notice] = 'Section has no reports.'
    end
  end

  def new
    @section = Section.find(params[:section_id])
  end

  def create
    @section = Section.find(params[:section_id])
    @section.reports << Report.new(:file => params[:report], :year => params[:date][:year], :stamp => Time.now)
    if @section.save
      flash.now[:notice] = "Report was successfully saved."
      redirect_to section_reports_url(@section)
    else
      render "new"
    end
  end

  def download
    @report = Report.find(params[:id])
    send_data(@report.data, :filename => @report.filename, :type => @report.content_type)
  end

  def destroy
    @report = Report.find(params[:id])
    if @report.destroy
      flash[:notice] = 'Report was successfully deleted.'
    end
    redirect_to section_reports_url
  end

end
