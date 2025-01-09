class ApplicationController < ActionController::Base
    private def current_user
        if session[:user_id]
            User.find_by(id: session[:user_id]) 
        elsif session[:admin_id]
            Admin.find_by(id: session[:admin_id])
        end
    end
    helper_method :current_user

    def update_cart_price
        cart.update!(price: cart.cart_items.sum { |c| c.price * c.quantity })
        puts "カートの合計金額を更新しました。"
    end

    helper_method :update_cart_price

    class LoginRequired < StandardError; end
    class Forbidden < StandardError; end

    if Rails.env.production? || ENV["RESCUE_EXCEPTIONS"]
        rescue_from StandardError, with: :rescue_internal_server_error
        rescue_from ActiveRecord::RecordNotFound, with: :rescue_not_found
        rescue_from ActionController::ParameterMissing, with: :rescue_bad_request
        rescue_from LoginRequired, with: :rescue_login_required
        rescue_from Forbidden, with: :rescue_forbidden
    end

    private def login_required
        raise LoginRequired unless current_user
    end

    private def rescue_bad_request(exception)
        render "errors/bad_request", status:400, layout: "error",formats: [:html]
    end

    private def rescue_login_required(exception)
        render "errors/login_required", status:403, layout: "error",formats: [:html]
    end

    private def rescue_forbidden(exception)
        render "errors/forbidden", status: 403, layout: "error",formats: [:html]
    end

    private def rescue_not_found(exception)
        render "errors/not_found", status:404, layout: "error",formats: [:html]
    end

    private def rescue_internal_server_error(exception)
        render "errors/internal_server_error", status: 500, layout: "error",formats: [:html]
    end

    private def update_expiration_time
        #cookies.signed[:member_id] = {value: cookies.signed[:member_id],expires:15.second.from_now}
        cookies.signed[:member_id] = {value: cookies.signed[:member_id],expires:24.hour.from_now}
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
            if admin?
                nil
            elsif login?
                return find_user_cart
            else
                find_or_create_session_cart
            end
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
