class FieldworkParticipationsController < ApplicationController
  before_filter :authorize

  def index
    @fieldwork = Fieldwork.find(params[:fieldwork_id]) # for show_menu
    @participations = FieldworkParticipation.all(:conditions => {:fieldwork_id => params[:fieldwork_id], :role => FieldworkParticipation::ROLE[:participant]})
    @leaderships = FieldworkParticipation.all(:conditions => {:fieldwork_id => params[:fieldwork_id], :role => FieldworkParticipation::ROLE[:leader]})
  end
  
  def registrations
    @fieldwork = Fieldwork.find(params[:fieldwork_id])
    @registrations = FieldworkParticipation.all(:conditions => {:fieldwork_id => params[:fieldwork_id], :role => FieldworkParticipation::ROLE[:applicant]})
  end

  def new
    @fieldwork = Fieldwork.find(params[:fieldwork_id])
    @members = Member.all
    if @members.empty?
      flash[:notice] = "No members in database."
    end
  end
  
  def apply
    @membership = FieldworkParticipation.new(:fieldwork_id => params[:fieldwork_id], :member_id => session[:user_id], :role => FieldworkParticipation::ROLE[:applicant], :joined => Date.today)
    if @membership.save
      flash[:notice] = "Application successfully submitted."
      redirect_to fieldwork_participations_url(params[:fieldwork_id])
    end
  end

  def create
    @participation = FieldworkParticipation.new(:fieldwork_id => params[:fieldwork_id], :member_id => params[:id], :role => FieldworkParticipation::ROLE[:participant], :joined => Date.today)
    if @participation.save
      flash[:notice] = "Participation successfully created."
      redirect_to fieldwork_participations_url(params[:fieldwork_id])
    else
      render "new"
    end
  end

  def update
    @participation = FieldworkParticipation.find(params[:id])
    if @participation.update_attribute(:role, params[:role])
      flash[:notice] = "Participation successfully updated."
      redirect_to fieldwork_participations_url(params[:fieldwork_id])
    end
  end

  def destroy
    @participation = FieldworkParticipation.find(params[:id])
    if @participation.destroy
      flash[:notice] = "Participation successfully destroyed."
      redirect_to fieldwork_participations_url(params[:fieldwork_id])
    end
  end
end
