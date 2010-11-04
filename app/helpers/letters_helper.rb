module LettersHelper
  def display_type(type)
    rs = case type
      when Transfer::TYPE[:incoming] then return "Ulazni"
      when Transfer::TYPE[:outgoing] then return "Izlazni"
    end
    return rs
  end
end
