module BookLoansHelper
  def book_loans_form(form)
    render :partial => 'form', :locals => {:f => form}
  end
end
