class ProjectItemsController < ApplicationController
  load_and_authorize_resource

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
