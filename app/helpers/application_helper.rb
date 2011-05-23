module ApplicationHelper
  def render_form(form_object, location)
    render :partial => location, :locals => {:f => form_object}
  end
end
