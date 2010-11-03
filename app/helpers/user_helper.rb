module UserHelper
 def display_auth_level(level)
    rs = case level
      when Member::ROLE[:member] then "Clan"
      when Member::ROLE[:leader] then "Voditelj(ica) sekcije"
      when MEMber::ROLE[:supervisory_board] then "Nadzorni odbor"
      when Member::ROLE[:administrative_board] then "Upravni odbor"
      when Member::ROLE[:root] then "Admin"
    end
    return rs
  end
end
