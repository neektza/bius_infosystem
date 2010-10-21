class FieldworkItemsController < ApplicationController
  before_filter :authorize

  def index
    @fieldwork = Fieldwork.find(params[:fieldwork_id])
    if @fieldwork.items.empty?
      flash.now[:notice] = "No fieldwork items."
    end
  end

  def add
    @fieldwork = Fieldwork.find(params[:fieldwork_id])
    @items = Item.all
    if @items.empty?
      flash[:items] = "No items in database."
    end
  end

  def create
    @fieldwork = Fieldwork.find(params[:fieldwork_id])
    @fieldwork.item_ids = params[:item_ids]
    if @fieldwork.save
	  flash[:notice] = "Fieldwork items were successfully added."
	  redirect_to fieldwork_items_url
	end
  end

  def destroy
    @fieldwork = Fieldwork.find(params[:fieldwork_id])
    @item = @fieldwork.items.find(params[:id])
      @fieldwork.items.delete(@item)
      if @fieldwork.save
        flash[:notice] = "Fieldwork item was successfully removed."
        redirect_to fieldwork_items_url
      end
  end

end

#unless @fieldwork.item_ids.include?(params[:item_id].to_i)
#      @item = Item.find(params[:item_id])
#      @fieldwork.items << @item unless @item == nil
#      @fieldwork.save
#      else
#      flash[:notice] = "Predmet je vec inventaru projekta"
#    end
