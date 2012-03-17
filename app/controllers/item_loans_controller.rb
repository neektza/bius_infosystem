class ItemLoansController < ApplicationController
  load_and_authorize_resource

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
    @loan = Loan.new
    @members = Member.members.sort! {|x, y| x.name <=> y.name}
  end

  def create
    @item = Item.find(params[:item_id])
    @item.loans << Loan.new(params[:loan])
    if @item.save
      flash.now[:notice] = "Item loan was successfully created."
      redirect_to item_loans_url(@item)
    else
      render new_item_loan_url(@item)
    end
  end

  def edit
    @item = Item.find(params[:item_id])
    @loan = Loan.find(params[:id])
    @members = Member.members.sort! {|x, y| x.name <=> y.name}
  end

  def update
    @item = Item.find(params[:item_id])
    @loan = Loan.find(params[:id])
    if @loan.update_attributes(params[:loan])
      flash.now[:notice] = "Item loan was successfully created."
      redirect_to item_loans_url(@item)
    else
      render new_item_loan(@item)
    end
  end

  def destroy
    @loan = Loan.find(params[:id])
    if @loan.destroy
      flash[:notice] = "Loan was successfully deleted."
      redirect_to item_loans_url(@item)
    end
  end

end
