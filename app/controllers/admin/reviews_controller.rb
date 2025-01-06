class Admin::ReviewsController < Admin::Base
    before_action :login_required, only: [:new, :create]
    def index
        if params[:user_id].present?
            @user = User.find(params[:user_id])
            @reviews = @user.reviews.order(id: :asc).page(params[:page]).per(30)
        else
            @reviews = Review.order(id: :asc).page(params[:page]).per(30)
        end
    end
    def destroy
        @review = Review.find(params[:id])
        if params[:item_id]
            @item = Item.find(params[:item_id])
            if @review.user_id == current_user.id && @review.destroy
                redirect_to admin_item_path(@item), notice: "レビューを削除しました。"
            else
                redirect_to admin_item_path(@item), notice: "レビューの削除に失敗しました。"
            end
        elsif params[:user_id]
            @user = User.find(params[:user_id])
            if @review.destroy
                redirect_to admin_user_reviews_path(@user), notice: "レビューを削除しました。"
            else
                redirect_to admin_user_reviews_path(@user), notice: "レビューの削除に失敗しました。"
            end
        else
            redirect_to root_path, alert: "必要なパラメータが不足しています。"
        end
    end
    def search
        @reviews = Review.search(params[:report],params[:q]).page(params[:page]).per(30)
        render "index"
    end
end
