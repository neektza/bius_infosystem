module ItemRequestsHelper
  def display_action(action)
    rs = case action
      when ItemRequest::Action::ASSIGNMENT then "Zaduzenje"
      when ItemRequest::Action::ASSIGNMENT then "Razduzenje"
    end
    return rs
  end
end
