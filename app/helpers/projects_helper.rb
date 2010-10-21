module ProjectsHelper
  def project_form(form)
    render :partial => 'form', :locals => {:f => form}
  end
end
