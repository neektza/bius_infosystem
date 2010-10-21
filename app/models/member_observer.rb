class MemberObserver < ActiveRecord::Observer 
  def before_save(member)  
    if member.is_active
      member.active_until = Date.new(Date.today.year+1,Date.today.month,Date.today.day)
    else
      member.active_until = nil
    end
  end  
end
