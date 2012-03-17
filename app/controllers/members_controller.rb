class MembersController < ApplicationController
  load_and_authorize_resource

  def index
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
      @members = Member.where(["first_name ILIKE ? OR last_name ILIKE ?", params[:keyword], params[:keyword]])
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

  # Show member details
  def show
    respond_to do |format|
      format.html
      format.xml { render :xml => @member.to_xml }
      format.json { render :json => @members.to_json }
    end
  end

end
