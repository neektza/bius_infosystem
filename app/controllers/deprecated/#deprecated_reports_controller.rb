class ReportsController < ApplicationController
  
  def index
    @reportable = Section.find(params[:section_id])
    #@reports = @section.section_reports(:order => 'year')
    @reports = @section.reports.sort { |a,b| a.year <=> b.year }
    if @section.reports.empty?
      flash[:notice] = 'Section has no reports.'
    end
  end

  def upload
    @section = Section.find(params[:section_id])    
    @section.section_reports << SectionReport.new(:file => params[:report], :year => params[:date][:year], :stamp => Time.now)
    if @section.save
      redirect_to(:action => :show_reports , :id => @section)
    else
      flash.now[:notice] = "Error occured during report saving!"
      render :action => 'create_report'
    end
  end

  def download
    @report = SectionReport.find(params[:report_id])
    send_data(@report.data, :filename => @report.filename, :type => @report.content_type)
  end

  def destroy
    @report = SectionReport.find(params[:report_id])
    if @report.destroy
      flash[:notice] = 'Report was successfully deleted.'
    end
    redirect_to(:action => :show_reports , :id => params[:id])
  end
  
end
