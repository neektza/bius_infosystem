class FieldworksController < ApplicationController
  before_filter :authorize
  before_filter :check_if_fieldwork_leader, :only => [:edit, :update]
  before_filter :check_if_administrative_board, :only => [:new, :create, :destroy]

  def index
    @fieldworks = Fieldwork.all
    if @fieldworks.empty?
      flash[:notice] = "No fieldworks in database."
    end
    respond_to do |format|
      format.html
      format.xml { render :xml => @fieldworks.to_xml }
    end
  end

  def search
    @fieldworks = []
    if params[:keyword]
      @fieldworks = Fieldwork.all(:conditions => ["location LIKE ?", "%#{params[:keyword]}%"])
      if @fieldworks.empty?
     	flash[:notice] = "No such fieldworks in database."
      end
    end
  end

  def show
    @fieldwork = Fieldwork.find(params[:id])
    respond_to do |format|
      format.html
      format.xml { render :xml => @fieldwork.to_xml }
    end
  end

  def new
	@fieldwork = Fieldwork.new
  end

  def edit
	@fieldwork = Fieldwork.find(params[:id])
  end

  def create
	@fieldwork = Fieldwork.new(params[:fieldwork])
	if @fieldwork.save
	  flash[:notice] = "Fieldwork was successfully created."
	  redirect_to fieldworks_url
	else
	  render "new"
	end
  end

  def update
	@fieldwork = Fieldwork.find(params[:id])
	if @fieldwork.update_attributes(params[:fieldwork])
	  flash[:notice] = "Fieldwork was successfully updated."
	  redirect_to fieldwork_url(@fieldwork)
	else
	  render "edit"
	end
  end

  def destroy
	@fieldwork = Fieldwork.find(params[:id])
	if @fieldwork.destroy
	  flash[:notice] = "Fieldwork was successfully deleted."
	  redirect_to :action => 'index'
	end
  end

end
