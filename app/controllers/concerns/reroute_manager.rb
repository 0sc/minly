module RerouteManager
  include ApplicationHelper

  def manage_redirection(target)
    #Do all the statistics
    if target.active
      manage_active_target(target)
    else
      manage_inactive_target(target.shortened)
    end
  end

  def set_url_deactivated_message(url)
    flash[:error] = "The url: #{host_url+url} has been deactivated by the owner."
    manage_inactive_target
  end

  def manage_active_target(target)
    target.save_this_visit
    redirect_to (target.original)
  end

  def manage_inactive_target
    current_user ? redirect_to dashboard_url : redirect_to root_path
  end
end
