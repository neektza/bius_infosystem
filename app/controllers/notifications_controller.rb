class NotificationsController < ApplicationController
  before_filter :authorize

  def index
	@notifications = Notification.all
	if @notifications.empty?
	  flash[:notice] = "No notifications to show."
	end
    respond_to do |format|
	  format.html
	  format.xml { render :xml => @notifications.to_xml }
	end
  end

  def relevant
	@member = Member.find(session[:user_id])
	@notifications = @member.tags.collect {|t| t.notifications}.flatten!
	if @member.tags.empty? or @notifications.empty?
	  @notifications = []
	  flash[:notice] = "No relevant notifications to show."
	end
    respond_to do |format|
	  format.html { render 'index' }
	  format.xml { render :xml => @notifications.to_xml }
	end
  end

  def search
	@notifications = []
	if params[:keyword]
	  @notifications = Notification.all( :conditions => ["title LIKE ?" , "%#{params[:keyword]}%"])
	  if @notifications.empty?
		flash[:notice] = "No such notifications in database."
	  end
	end
  end

  def show
	@notification = Notification.find(params[:id])
  end

  def new
	@notification = Notification.new
	@tags = Tag.all
	if @tags.empty?
	  flash.now[:tags] = "No tags in database."
	end
  end

  def edit
	@notification = Notification.find(params[:id])
	@tags = Tag.all
	if @tags.empty?
	  flash.now[:tags] = "No tags in database."
	end
  end

  def create
	@tags = Tag.all
	@notification = Notification.new(params[:notification])
	@notification.sent = false
	@notification.tag_ids = params[:tag_ids] if params[:tag_ids]
	if @notification.save
	  flash.now[:notice] = "Notification was successfully created."
	  redirect_to :action => 'index'
	else
	  render "new"
	end
  end

  def update
	@notification = Notification.find(params[:id])
	@notification.tag_ids = params[:tag_ids] if params[:tag_ids]
	@notification.sent = false
	if @notification.update_attributes(params[:notification])
	  flash[:notice] = "Notification was successfully updated."
	  redirect_to :action => 'index'
	end
  end

  def destroy
	@notification = Notification.find(params[:id])
	if @notification.destroy
	  flash[:notice] = 'Notification was successfully deleted.'
	  redirect_to :action => 'index'
	end
  end

  def mail
	test_string = ""
	@notifications = Notification.all(:conditions => {:sent => false})
	@notifications.each do |n|
	  n.toggle(:sent)
	  n.save
	  recipients = n.tags.collect {|t| t.members}.flatten!
	  #email =
	  InfoMailer.deliver_notification(subject = "notification", body = n.body, recipients = recipients)
	  #test_string += "<pre>" + email.encoded + "</pre><hr/>"
	end
	#render(:text => test_string)
	unless @notifications.empty?
	  flash[:notice] = "Notifications sent."
	else
	  flash[:notice] = "All notifications previously sent."
	end
	redirect_to notifications_url
  end

end
