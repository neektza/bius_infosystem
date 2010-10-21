class ProjectItemsController < ApplicationController
  before_filter :authorize

  def index
    @project = Project.find(params[:project_id])
    if @project.items.empty?
      flash.now[:notice] = "No project items."
    end
  end

  def add
    @project = Project.find(params[:project_id])
    @items = Item.all
    if @items.empty?
	  flash[:items] = "No items in database."
	end
  end

  def create
    @project = Project.find(params[:project_id])
    @project.item_ids = params[:item_ids]
    if @project.save
	  flash[:notice] = "Project items were successfully added."
	  redirect_to project_items_url
	end
  end

  def destroy
    @project = Project.find(params[:project_id])
    @item = @project.items.find(params[:id])
      @project.items.delete(@item)
      if @project.save
        flash[:notice] = "Project item was successfully removed."
        redirect_to project_items_url
      end
  end

end

#unless @project.item_ids.include?(params[:item_id].to_i)
#      @item = Item.find(params[:item_id])
#      @project.items << @item unless @item == nil
#      @project.save
#      else
#      flash[:notice] = "Predmet je vec inventaru projekta"
#    end
