class Admin::CategoriesController < Admin::Base
    def index
        @categories = Category.order(id: :asc)
    end
    def show
        @category = Category.find(params[:id])
    end
    def new
        @category = Category.new
    end
    def edit
        @category = Category.find(params[:id])
    end
    def update
        @category = Category.find(params[:id])
        @category.assign_attributes(params[:category])
        if @category.save
            redirect_to [:admin,@category], notice: "カテゴリを更新しました。"
        else
            render "edit"
        end
    end
    def create
        @category = Category.new(params[:category])
        if @category.save
            redirect_to [:admin,@category], notice: "カテゴリを登録しました。"
        else
            render "new"
        end
    end
    def destroy
        @category = Category.find(params[:id])
        if @category.destroy
            redirect_to admin_categories_path, notice: "カテゴリを削除しました。"
        else
            redirect_to admin_categories_path, alert: "カテゴリの削除に失敗しました。"
        end
    end
end
