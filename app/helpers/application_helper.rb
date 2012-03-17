module ApplicationHelper
  def render_form(location, form_object)
    render :partial => location, :locals => {:f => form_object}
  end
end
