class ItemsController < ApplicationController
  before_filter :authorize
  before_filter :check_if_administrative_board, :only => [:add, :edit, :listreqs, :allow, :deny]
  before_filter :check_if_item_in_possession, :only => [:dealloc]

  def index
    @items = Item.all
    if @items.empty?
      flash[:notice] = "No items in database."
    end
    
    respond_to do |format|
      format.html
      format.xml { render :xml => @items.to_xml }
      format.json { render :json => @items.to_json }
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
    @procurers = Member.all
  end

  def edit
    @item = Item.find(params[:id])
    @procurers = Member.all
  end

  def create
    @item = Item.new(params[:item])
    if @item.save
      flash.now[:notice] = "Item was successfully created."
      redirect_to items_url
    else
      @procurers = Member.all
      render new_item_path
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(params[:item])
      flash.now[:notice] = "Item was successfully updated."
      redirect_to items_url
    else
      render edit_item_url
    end
  end

  def destroy
    @item = Item.find(params[:id])
    if @item.destroy
      redirect_to items_url
    end
  end

  def requests
    @requests = ItemRequest.all(:order => "date_requested DESC")
    if @requests.empty?
      flash[:notice] = "No item requests."
    end
  end

  def loans
    @loans = ItemLoan.all
    if @loans.empty?
      flash[:notice] = "No item loans."
    end
  end

  def history
    @item = Item.find(params[:id])
    if @item.loans.empty?
      flash[:notice] = "No item history."
    end
  end

  def assign
    @item = Item.find(params[:id])
    @item_request = ItemRequest.new({:item_id => params[:id], :requester_id => session[:user_id] , :date_requested => Time.now, :action => ItemRequest::Action::ASSIGNMENT})
    if @item_request.save
      flash[:notice] = "Item assignment requested, waiting for approval..."
      redirect_to item_url(@item)
    else
      render "show"
    end
  end

  #TODO provjeriti postoji li posudba prije razduzenja
  def deassign
    @item = Item.find(params[:id])
    @item_request = ItemRequest.new({:item_id => params[:id], :requester_id => session[:user_id] , :date_requested => Time.now, :action => ItemRequest::Action::DEASSIGNMENT})
    if @item_request.save
      flash[:notice] = "Item deassignment requested, waiting for approval..."
      redirect_to item_url(@item)
    else
      render "show"
    end
  end

end
