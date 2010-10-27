class FieldworkReportsController < ApplicationController
  before_filter :authorize

  def show
    @fieldwork = Fieldwork.find(params[:fieldwork_id])
    if @fieldwork.report.nil?
      flash[:notice] = 'Fieldwork has no report.'
    end
  end

  def new
    @fieldwork = Fieldwork.find(params[:fieldwork_id])
  end

  def create
    @fieldwork = Fieldwork.find(params[:fieldwork_id])
    @fieldwork.report = Report.new(:file => params[:report], :year => Time.now.year , :stamp => Time.now)
    if @fieldwork.save
      flash.now[:notice] = "Report was successfully saved."
      redirect_to fieldwork_report_url(@fieldwork)
    end
  end

  def download
    @report = Fieldwork.find(params[:fieldwork_id]).report
    send_data(@report.data, :filename => @report.filename, :type => @report.content_type)
  end

  def destroy
    @report = Fieldwork.find(params[:fieldwork_id]).report
    if @report.destroy
      flash[:notice] = 'Report was successfully deleted.'
    end
    redirect_to fieldwork_report_url
  end

end
