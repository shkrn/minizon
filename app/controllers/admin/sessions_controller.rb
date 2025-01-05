#管理者専用フォームでログイン
class Admin::SessionsController < Admin::Base
    skip_before_action :admin_login_required, only: [:create,:destroy]
    def create
        
        admin = Admin.find_by(email: params[:email])
        if admin&.authenticate(params[:password])
            reset_session
            session[:admin_id] = admin.id
            redirect_to admin_root_path, notice: '管理者アカウントでログインしました(a)'
        else
            flash.alert = "名前とパスワードが一致しません"
        end
    end

    def destroy
        session.delete(:admin_id)
        session.delete(:user_id)
        redirect_to admin_root_path, notice: 'ログアウトしました'
    end
end

