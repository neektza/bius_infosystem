class MembersController < ApplicationController
  before_filter :authorize
  
  #before_filter :check_if_destroy_self, :only => [:destroy]
  #before_filter :check_if_administrative_board , :only => [:new, :edit, :create, :update, :destroy]
  #before_filter :check_if_supervisory_board, :only => [:show]

  # Find only active members 
  #TODO: put order by in sql and BOOL to CHAR(1)
  def index
	@members = Member.all(:conditions => ["auth_level >= ? AND is_active = ?", Member::ROLE[:member], true])
    @members.sort! { |a,b| a.membership_card_nmb.to_i <=> b.membership_card_nmb.to_i }
	if @members.empty?
	  flash[:notice] = "messages.members.index.empty"
	end
	respond_to do |format|
	  format.html { render :index }
	  format.xml { render :xml => @members.to_xml }
	  format.json { render :json => @members.to_json }
	end
  end

  # Find all members 
  def all
	@members = Member.all(:conditions => ["auth_level >= ?", Member::ROLE[:member]])
    @members.sort! { |a,b| a.membership_card_nmb.to_i <=> b.membership_card_nmb.to_i }
	if @members.empty?
	  flash[:notice] = "messages.members.index.empty"
	end
	respond_to do |format|
	  format.html { render :index }
	  format.xml { render :xml => @members.to_xml }
	  format.json { render :json => @members.to_json }
	end
  end

  # Search members by criteria 
  def search
	@members = []
	if params[:keyword]
      params[:keyword] = '%' + params[:keyword] + '%'
	  @members = Member.where(["first_name ILIKE ? OR last_name ILIKE ? OR username ILIKE ?", params[:keyword], params[:keyword], params[:keyword]])
	  if @members.empty?
		flash[:notice] = "messages.members.search.empty"
	  end
	  respond_to do |format|
		format.html
		format.xml { render :xml => @members.to_xml }
		format.json { render :json => @members.to_json }
	  end
	end
  end

  # Get all registrations
  def registrations
    @registrations = Member.all(:conditions => ["auth_level = ?", Member::ROLE[:applicant]])
	if @registrations.empty?
	  flash[:notice] = "messages.members.registrations.empty"
	end
	respond_to do |format|
	  format.html
	  format.xml { render :xml => @registrations.to_xml }
	  format.json { render :json => @registrations.to_json }
	end
  end

  # Accept member registration
  def accept
    @registration = Member.find(params[:id])
    @registration.auth_level = Member::ROLE[:member]
    if @registration.save
	  flash[:notice] = "messages.registration.accepted"
      redirect_to registrations_members_url
    else
      render :registrations
    end
  end

  # Reject member registration
  # Could also be done by destroyng member directly form view
  def reject
    @registration = Member.find(params[:id])
    if @registration.destroy
      flash[:notice] = "messages.registration.rejected"
      redirect_to registrations_members_url
    else
      render :registrations
    end 
  end

  # Show member details
  def show
	@member = Member.find(params[:id])
	respond_to do |format|
	  format.html
	  format.xml { render :xml => @member.to_xml }
	  format.json { render :json => @members.to_json }
	end
  end

  # New member object (for form)
  def new
	@member = Member.new
  end

  # Find member object (for form)
  def edit
	@member = Member.find(params[:id])
  end

  # Create a member
  def create
	@member = Member.new(params[:member])
	@member.auth_level = Member::ROLE[:member]
	if @member.save
	  flash.now[:notice] = "message.member.new"
	  redirect_to members_url
	else
	  render "new"
	end
  end
  
  # Update a member
  def update
	@member = Member.find(params[:id])
	if @member.update_attributes(params[:member])
	  flash.now[:notice] = "Member was successfully updated."
	  redirect_to member_url(@member)
	else
	  render "edit"
	end
  end

  # Destroy a member
  def destroy
	@member = Member.find(params[:id])
	if @member.destroy
	  flash[:notice] = "Member was successfully deleted."
	  redirect_to members_url
	end
  end

end
