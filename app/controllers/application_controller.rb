class ApplicationController < ActionController::Base
    private def current_user
        if session[:user_id]
            User.find_by(id: session[:user_id]) 
        elsif session[:admin_id]
            Admin.find_by(id: session[:admin_id])
        end
    end
    helper_method :current_user

    class LoginRequired < StandardError; end
    class Forbidden < StandardError; end
    private def login_required
        raise LoginRequired unless current_user
    end

    def login?
        !!current_user
    end 

    private def current_cart
        if login?
            Cart.find_by(user_id: current_user.id)
        else
            if session[:cart_id]
                Cart.find_by(id: session[:cart_id])
            else
                Cart.create(id: session[:cart_id])
            end
        end
    end

    helper_method :login?
    helper_method :current_cart

    def admin?
        current_user.is_a?(Admin)
    end
    helper_method :admin?
end
