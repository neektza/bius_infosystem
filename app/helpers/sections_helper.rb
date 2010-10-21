module SectionsHelper
  def section_form(form)
    render :partial => 'form', :locals => {:f => form}
  end
end
