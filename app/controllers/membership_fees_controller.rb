class MembershipFeesController < ApplicationController
  def index
    @member = Member.find(params[:member_id])
  end

  def new
    @member = Member.find(params[:member_id])
  end

  def create
    @member = Member.find(params[:member_id])
    @fee = MembershipFee.new(params[:membership_fee])
    @member.fees << @fee
    if @member.save
      flash[:notice] = 'poruka'
      redirect_to member_url(@member)
    end
  end

  def destroy
  end
end
