class Seller::ReviewsController < Seller::Base
    before_action :login_required, only: [:new, :create, :edit, :update, :destroy]
    def index
        @reviews = Review.joins(:item).where(items: { user_id: current_user.id }).order(created_at: :desc).page(params[:page]).per(30)
    end
    def report
        @review = Review.find(params[:id])
        @review.report = true
        if @review.save
            redirect_to seller_reviews_path, notice: "レビューを通報しました。"
        else
            redirect_to seller_reviews_path, notice: "レビューの通報に失敗しました。"
        end
    end
    def search
        @reviews = Review.search(params[:q]).page(params[:page]).per(30)
        render "index"
    end
end
