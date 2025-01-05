class Admin::TopController < Admin::Base
  layout false, only: [:login]
  skip_before_action :admin_login_required, only: [:login]
  def index
    
  end
  def login
    if admin?
      redirect_to admin_root_path
      puts "管理者としてログインしています"
    end
  end
end
