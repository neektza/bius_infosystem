module UserHelper
  def user_form(form)
    render :partial => 'form', :locals => {:f => form}
  end
end
