module RerouteHelper
  def manage_redirection(target)
    #Do all the statistics
    if target.active
      manage_active_target(target)
    else
      manage_inactive_target(target.shortened)
    end
  end

  def manage_inactive_target(url)
    flash[:error] = "The url: #{host_url+url} has been deactivated by the owner."
    redirect_to root_path
  end

  def manage_active_target(target)
    target.save_this_visit
    redirect_to (target.original)
  end
end
