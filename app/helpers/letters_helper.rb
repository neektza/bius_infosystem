module LettersHelper
  def letter_form(form)
    render :partial => 'form', :locals => {:f => form}
  end
end
