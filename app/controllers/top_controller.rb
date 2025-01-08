class TopController < ApplicationController
  layout false, only: [:login]
  def index
  end
  def login
    if admin?
      redirect_to admin_root_path
      puts "管理者としてログインしています"
    end
  end
  def bad_request
    raise ActionController::ParameterMissing,""
  end

  def forbidden
    raise Forbidden,""
  end

  def internal_server_error
    raise
  end
end
