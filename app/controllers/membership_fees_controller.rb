class MembershipFeesController < ApplicationController
  def index
    @member = Member.find(params[:member_id])
    @fees = @member.membership_fees
  end

  def new
    @member = Member.find(params[:member_id])
    @fee = MembershipFee.new
  end

  def create
    @member = Member.find(params[:member_id])
    @fee = MembershipFee.new
    @fee.year = params[:date][:year]
    @member.membership_fees << @fee
    if @member.save
      flash[:notice] = 'poruka'
      redirect_to member_membership_fees_url(@member)
    end
  end

  def destroy
    @fee = MembershipFee.find(params[:id])
	if @fee.destroy
	  flash[:notice] = "Fee was successfully deleted."
      redirect_to member_membership_fees_url(@member)
	end
  end
end
