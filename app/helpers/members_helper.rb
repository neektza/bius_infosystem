module MembersHelper
  def display_auth_level(level)
    rs = case level
      when Member::AuthLevel::MEMBER then "Clan"
      when Member::AuthLevel::LEADER then "Voditelj(ica) sekcije"
      when Member::AuthLevel::SUPERVISORY_BOARD then "Nadzorni odbor"
      when Member::AuthLevel::ADMINISTRATIVE_BOARD then "Upravni odbor"
      when Member::AuthLevel::ROOT then "Admin"
    end
    return rs
  end

  def member_form(form)
    render :partial => 'form', :locals => {:f => form}
  end
end
