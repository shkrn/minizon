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

    private def current_cart1
        if login?
            Cart.find_by(user_id: current_user.id)
            puts "-------------------"
            puts"ログインしている場合にカートを取得"
        else
            if session[:cart_id]
                Cart.find_by(id: session[:cart_id])
                puts "-------------------"
                puts"ログインしていない場合にカートを取得"
                puts session[:cart_id]
            else
                cart = Cart.create
                session[:cart_id]=cart.id
                cart
                puts "-------------------" 
                puts"カートを新規作成"
            end
        end
    end

    private def current_cart
        return find_user_cart if login?
        find_or_create_session_cart
    end

    private def find_user_cart
        Cart.find_by(user_id: current_user.id) || Cart.create(user_id: current_user.id)
    end
    
    private def find_or_create_session_cart
        if session[:cart_id]
            cart = Cart.find_by(id: session[:cart_id])
            return cart if cart.present?
        end
        create_new_session_cart
    end
    private def create_new_session_cart
        cart = Cart.create
        session[:cart_id] = cart.id
        cart
    end
    
    helper_method :create_new_session_cart

    helper_method :login?
    helper_method :current_cart

    def admin?
        current_user.is_a?(Admin)
    end
    helper_method :admin?
end
