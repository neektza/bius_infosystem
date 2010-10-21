class SubscriptionsController < ApplicationController
  before_filter :authorize

  def index
	@member = Member.find(params[:member_id])
	@subscriptions = @member.tags
	if @subscriptions.empty?
	  flash[:notice] = "No subscriptions."
	end
  end

  def change
	@member = Member.find(params[:member_id])
	@subscriptions = Tag.all
	if @subscriptions.empty?
	  flash[:tags] = "No tags in database."
	end
  end

  def create
	@member = Member.find(session[:user_id])
	@member.tag_ids = params[:tag_ids]
	if @member.save
	  flash[:notice] = "Subsriptions were successfully created."
	  redirect_to :action => 'index'
	end
  end
end
