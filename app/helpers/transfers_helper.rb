module TransfersHelper
  def display_type(type)
    rs = case type
      when Transfer::Incoming::TYPE then return "Ulazni"
      when Transfer::Outgoing::TYPE then return "Izlazni"
    end
    return rs
  end

  def transfer_form(form)
    render :partial => 'form', :locals => {:f => form}
  end
end
