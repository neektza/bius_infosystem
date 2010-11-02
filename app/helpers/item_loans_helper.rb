module ItemLoansHelper
  def item_loans_form(form)
    render :partial => 'form', :locals => {:f => form}
  end
end
