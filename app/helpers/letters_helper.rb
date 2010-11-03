module LettersHelper
  def display_type(type)
    rs = case type
      when Transfer::Incoming::TYPE then return "Ulazni"
      when Transfer::Outgoing::TYPE then return "Izlazni"
    end
    return rs
  end
end
