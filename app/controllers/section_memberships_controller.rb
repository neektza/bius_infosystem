class SectionMembershipsController < ApplicationController
  load_and_authorize_resource :section
  load_and_authorize_resource :through => :section

  # Get membersips for section
  def index
    @memberships = SectionMembership.all(:conditions => {:section_id => params[:section_id], :role => SectionMembership::ROLE[:member]})
    @leaderships = SectionMembership.all(:conditions => {:section_id => params[:section_id], :role => SectionMembership::ROLE[:leader]})
  end

  # Get potential (all) members for memberships
  def new
    @members = Member.all
    if @members.empty?
      flash[:notice] = "No members in database."
    end
  end

  # Create section membership
  def create
    @membership = SectionMembership.new(:section_id => params[:section_id], :member_id => params[:member_id], :role => SectionMembership::ROLE[:member], :joined => Date.today)
    if @membership.save
      flash[:notice] = "Membership successfully created."
      redirect_to section_memberships_url(params[:section_id])
    else
      render "new"
    end
  end
 
  # Update section membership (update membership role) 
  def update
    @membership = SectionMembership.find(params[:id])
    if @membership.update_attribute(:role, params[:role])
      flash[:notice] = "Membership successfully updated."
      redirect_to section_memberships_url(params[:section_id])
    end
  end

  # Destroy section membership
  def destroy
    @membership = SectionMembership.find(params[:id])
    if @membership.destroy
      flash[:notice] = "Membership successfully destroyed."
      redirect_to section_memberships_url(params[:section_id])
    end
  end
  
  # Get registrations for section 
  def registrations
    @section = Section.find(params[:section_id]) # for show_menu
    @registrations = SectionMembership.all(:conditions => {:section_id => params[:section_id], :role => SectionMembership::ROLE[:applicant]})
    authorize! :update, Section
  end
  
  # Apply for section membership
  def apply
    @membership = SectionMembership.new(:section_id => params[:section_id], :member_id => current_member.id, :role => SectionMembership::ROLE[:applicant], :joined => Date.today)
    if @membership.save
      flash[:notice] = "Application successfully submitted."
      redirect_to section_memberships_url(params[:section_id])
    end
    authorize! :apply, SectionMembership
  end

end
