class MemberItemsController < ApplicationController
  before_filter :authorize

  # List items of a member
  def index
    @member = Member.find(params[:member_id])
    @items_in_possession = @member.items_in_possession
    @items_taken = @member.items_taken
    render "members/list_items"
  end
end
