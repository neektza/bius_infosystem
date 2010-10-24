class ItemLoansController < ApplicationController
  before_filter :authorize
  
  def index
    @item = Item.find(params[:item_id])
    if @item.loans.empty?
      flash[:notice] = "No item loans."
    end
  end

  def history
    @item = Item.find(params[:id])
    if @item.loans.empty?
      flash[:notice] = "No item history."
    end
  end

  def new
    @item = Item.find(params[:item_id])
    @item_loan = ItemLoan.new
    @members = Member.members.sort! {|x, y| x.name <=> y.name}
  end

  def create
    @item = Item.find(params[:item_id])
    @item_loan = ItemLoan.create(params[:item_loan])
    @item.loans << @item_loan
    if @item.save
      flash.now[:notice] = "Item loan was successfully created."
      redirect_to item_loans_url(@item)
    else
      render new_item_loan(@item)
    end
  end

  def edit
    @item = Item.find(params[:item_id])
    @item_loan = ItemLoan.find(params[:id])
    @members = Member.members.sort! {|x, y| x.name <=> y.name}
  end

  def update
    @item = Item.find(params[:item_id])
    @item_loan = ItemLoan.find(params[:id])

    @item_loan = ItemLoan.update_attributes(params[:item_loan])
    if @item_loan.save
      flash.now[:notice] = "Item loan was successfully created."
      redirect_to item_loans_url(@item)
    else
      render new_item_loan(@item)
    end

  end

end
