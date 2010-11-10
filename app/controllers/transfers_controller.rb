class TransfersController < ApplicationController
  before_filter :authorize

  def index
    @transfers = Transfer.all
    if @transfers.empty?
        flash.now[:notice] = "No transfers in database."
    end
    
    respond_to do |format|
      format.html
      format.xml { render :xml => @transfers.to_xml }
    end
  end

  def search
	@transfers = []
	if params[:keyword]
      params[:keyword] = '%' + params[:keyword] + '%'
	  @transfers = Transfer.where("purpose ILIKE ?" , params[:keyword]])
	  if @transfers.empty?
		flash[:notice] = "messages.transfers.search.empty"
	  end
	  respond_to do |format|
		format.html
		format.xml { render :xml => @transfers.to_xml }
		format.json { render :json => @transfers.to_json }
	  end
	end
  end

  def secret
    @transfers = Transfer.all(:conditions => {:is_secret => true})
    if @transfers.empty?
        flash.now[:notice] = "No such transfers in database."
    end
   
    respond_to do |format|
      format.html { render "index" }
      format.xml { render :xml => @transfers.to_xml }
    end
  end

  def incoming
    @transfers = Transfer.all(:conditions => {:in_out => Transfer::TYPE[:incoming]})
    if @transfers.empty?
        flash.now[:notice] = "No such transfers in database."
    end

    respond_to do |format|
      format.html { render "index" }
      format.xml { render :xml => @transfers.to_xml }
    end
  end

  def outgoing
    @transfers = Transfer.all(:conditions => {:in_out => Transfer::TYPE[:outgoing]})
    if @transfers.empty?
        flash.now[:notice] = "No such transfers in database."
    end

    respond_to do |format|
      format.html { render "index" }
      format.xml { render :xml => @transfers.to_xml }
    end
  end

  def show
    @transfer = Transfer.find(params[:id])
  end

  def new
    @transfer = Transfer.new
  end
  
  def create
    @transfer = Transfer.new(params[:transfer])
    if @transfer.save
      flash.now[:notice] = "Transfer was successfully created."
      redirect_to transfers_url
    else
      render "new"
    end
  end

  def edit
    @transfer = Transfer.find(params[:id])
  end

  def update
    @transfer = Transfer.find(params[:id])
    if @transfer.update_attributes(params[:transfer])
      flash.now[:notice] = "Transfer was successfully updated."
      redirect_to transfer_url(@transfer)
    else
      render "edit"
    end
  end

  def destroy
    @transfer = Transfer.find(params[:id])
    if @transfer.destroy
      flash[:notice] = "Transfer was successfully deleted."
      redirect_to transfers_url
    end
  end

end
