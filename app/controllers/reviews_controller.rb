class ReviewsController < ApplicationController
    before_action :login_required, only: [:new, :create]
    def index
        @reviews = Review.order(created_at: :desc).page(params[:page]).per(30)
        @myreviews = current_user.reviews.order(created_at: :desc)
    end
    def new
        @review = Review.new
        @item = Item.find(params[:item_id])
    end
    def create
        @review = Review.new(params[:review])
        @review.user_id = current_user.id
        @review.item_id = params[:item_id]
        if @review.save
            redirect_to item_path(params[:item_id]), notice: "レビューを登録しました。"
        else
            render "new"
        end
    end
    def edit
        @review = Review.find(params[:id])
        if params[:item_id]
            @item = Item.find(params[:item_id])
        elsif params[:user_id]
            @user = User.find(params[:user_id])
        end
    end
    def update
        @review = Review.find(params[:id])
        @review.assign_attributes(params[:review])
        if @review.user_id == current_user.id && @review.save
            redirect_to item_path(params[:item_id]), notice: "レビューを更新しました。"
        else
            render "edit", notice: "レビューの更新に失敗しました。"
        end
    end
    def destroy
        @review = Review.find(params[:id])
        if params[:item_id]
            @item = Item.find(params[:item_id])
            if @review.user_id == current_user.id && @review.destroy
                redirect_to item_path(@item), notice: "レビューを削除しました。"
            else
                redirect_to item_path(@item), notice: "レビューの削除に失敗しました。"
            end
        elsif params[:user_id]
            @user = User.find(params[:user_id])
            if @review.destroy
                redirect_to user_reviews_path(@user), notice: "レビューを削除しました。"
            else
                redirect_to user_reviews_path(@user), notice: "レビューの削除に失敗しました。"
            end
        else
            redirect_to root_path, alert: "必要なパラメータが不足しています。"
        end
    end
    def report
        @review = Review.find(params[:id])
        @review.report = true
        if @review.save
            redirect_to item_path(@review.item_id), notice: "レビューを通報しました。"
        else
            redirect_to item_path(@review.item_id), notice: "レビューの通報に失敗しました。"
        end
    end
    def search
        @reviews = Review.search(params[:q]).page(params[:page]).per(30)
        render "index"
    end
end
