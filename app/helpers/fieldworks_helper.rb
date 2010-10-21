module FieldworksHelper
  def fieldworks_form(form)
    render :partial => 'form', :locals => {:f => form}
  end
end
