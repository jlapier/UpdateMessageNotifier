module ApplicationHelper
  def new_update_for_user
    return @new_update_for_user if @new_update_for_user
    if current_user and current_user.last_read_message != most_recent_update
      @new_update_for_user = most_recent_update
    end
  end
end
