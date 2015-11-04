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

  def manage_active_target(target)
    target.save_this_visit
    redirect_to (target.original)
  end

  def manage_inactive_target(target)
    set_url_deactivated_message(target)
    if current_user
      redirect_to dashboard_url
    else
      redirect_to root_path
    end
  end

  def manage_missing_target(target)
    set_url_missing_message(target)
    if current_user
      redirect_to dashboard_url
    else
      redirect_to root_path
    end
  end

  def set_url_deactivated_message(url)
    flash[:error] = "The url: #{host_url+url} has been deactivated by the owner."
  end

  def set_url_missing_message(url)
    flash[:error] = "Oops! We couldn't find target url: #{host_url}#{url}. It may have been deleted."
  end

end
