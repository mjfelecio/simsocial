class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Redirects the user to create profile after login or signup if they have no username
  def after_sign_in_path_for(resource)
    if current_user.username.blank?
      user_new_profile_path(current_user)
    else
      root_path
    end
  end

  def after_sign_up_path_for(resource)
    if current_user.username.blank?
      user_new_profile_path(current_user)
    else
      root_path
    end
  end
end
