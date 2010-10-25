class FieldworkParticipationsController < ApplicationController
  before_filter :authorize

  def index
    @fieldwork = Fieldwork.find(params[:fieldwork_id])
    @participations = FieldworkParticipation.all(:conditions => {:role => FieldworkParticipation::Role::PARTICIPANT})
    @leaderships = FieldworkParticipation.all(:conditions => {:role => FieldworkParticipation::Role::LEADER})
  end

  def new
    @fieldwork = Fieldwork.find(params[:fieldwork_id])
    @members = Member.all
    if @members.empty?
      flash[:notice] = "No members in database."
    end
  end

  def create
    @participation = FieldworkParticipation.new(:fieldwork_id => params[:fieldwork_id], :member_id => params[:id], :role => FieldworkParticipation::Role::PARTICIPANT, :joined => Date.today)
    if @participation.save
      flash[:notice] = "Participation successfully created."
      redirect_to fieldwork_participations_url(params[:fieldwork_id])
    else
      render new_fieldwork_participation_url(params[:fieldwork_id])
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
