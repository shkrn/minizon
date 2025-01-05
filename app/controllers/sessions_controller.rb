# class SessionsController < ApplicationController
#     def create
#         user = User.find_by(email: params[:email])
#         if user&.authenticate(params[:password])
#             #cookies.signed[:member_id] = {value:member.id,expires:15.second.from_now}
#             session[:user_id] = user.id
#         else
#             flash.alert = "名前とパスワードが一致しません"
#         end
#         redirect_to :root
#     end

#     def destroy
#         session.delete(:user_id)
#         redirect_to :root
#     end
# end


class SessionsController < ApplicationController
    def new
      # ログインフォームを表示
    end
  
    def create
      # 一般ユーザーのログイン判定
      @user = User.find_by(email: params[:email])
      @admin = Admin.find_by(email: params[:email])
  
      # ユーザーが一般ユーザーか管理者かを判定
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to root_path, notice: '一般ユーザーとしてログインしました！'
      elsif @admin && @admin.authenticate(params[:password])
        session[:admin_id] = @admin.id
        redirect_to admin_root_path, notice: '管理者としてログインしました！'
      else
        flash.now[:alert] = 'メールアドレスまたはパスワードが間違っています。'
        redirect_to root_path
      end
    end
  
    def destroy
      session.delete(:user_id)
      session.delete(:admin_id)
      redirect_to root_path, notice: 'ログアウトしました。'
    end
  end