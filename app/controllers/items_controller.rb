class ItemsController < ApplicationController
  load_and_authorize_resource

  def index
    @items = Item.all
    if @items.empty?
      flash[:notice] = "No items in database."
    end
  end

  def loans
    @loans = Loan.all(:conditions => {:date_to => nil, :loanable_type => "Item"})
    if @loans.empty?
      flash[:notice] = "No loans in database."
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def edit
    @item = Item.find(params[:id])
  end

  def create
    @item = Item.new(params[:item])
    if @item.save
      flash.now[:notice] = "Item was successfully created."
      redirect_to items_url
    else
      render new_item_url
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

end
