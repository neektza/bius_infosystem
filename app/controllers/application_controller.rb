class ApplicationController < ActionController::Base
  before_filter :authenticate_member!
  
  helper :all
  layout 'application'
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :notice => "Access denied." 
  end

  def current_ability
    @current_ability ||= Ability.new(current_member)
  end

end
