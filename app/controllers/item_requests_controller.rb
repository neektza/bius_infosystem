class ItemRequestsController < ApplicationController
  before_filter :authorize

  def index
    @item = Item.find(params[:item_id])
    if @item.requests.empty?
      flash[:notice] = "No item requests."
    end
  end

  def allow
    @item_req = ItemRequest.find(params[:id])
    @item = @item_req.item
    if @item_req.action == ItemRequest::Action::ASSIGNMENT
      @item.loans << @item_loan = ItemLoan.new({:taker_id => @item_req.requester_id , :giver_id => session[:user_id] , :item_id => @item_req.item.id , :date_from => Time.now}) 
      @item.taker_id = @item_req.requester_id
    end
    if @item_req.action == ItemRequest::Action::DEASSIGNMENT
      @item_loan = ItemLoan.find_by_item_id_and_taker_id_and_date_to(@item_req.item.id , @item_req.requester_id, nil)
      @item_loan.date_to = Time.now
      @item.taker_id = nil
    end
    if @item.save and @item_loan.save and @item_req.destroy
      flash[:notice] = "*eng Zahtjev odobren"
      redirect_to loans_items_url
    else
      redirect_to item_requests(@item) 
    end
  end

  def deny
    @item_req = ItemRequest.find(params[:id])
    if @item_req.destroy
      flash[:notice] = "*eng Zahtjev odbijen"
      redirect_to requests_items_url
    end
  end

end
