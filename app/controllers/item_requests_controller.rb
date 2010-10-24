class ItemLoansController < ApplicationController
  before_filter :authorize


  def index
    @loans = ItemLoan.all
    if @loans.empty?
      flash[:notice] = "No loans."
    end
  end

  def active
    @item = Item.find(params[:item_id])
    if @item.active_loans.empty?
      flash[:notice] = "No active item loans."
    end
  end

  def history
    @item = Item.find(params[:id])
    if @item.loans.empty?
      flash[:notice] = "No item loans."
    end
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
