class Admin::Base < ApplicationController
  before_action :admin_login_required
  
  #private def admin_login_required
  #   raise Forbidden unless current_user.is_a?(Admin)
  # end

  private def admin_login_required
    unless current_user&.is_a?(Admin)
      flash.alert = "管理者としてログインしてください"
      redirect_to admin_login_path
    end
  end

  # private def admin_login_required
  #   return if controller_name == 'sessions' && ['new', 'create'].include?(action_name)
  #   return if current_user&.is_a?(Admin)
    
  #   flash.alert = "管理者としてログインしてください"
  #   redirect_to admin_login_path
  # end
end