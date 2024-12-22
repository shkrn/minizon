class AccountsController < ApplicationController
  before_action :login_required
  def show
    @user = current_user
  end

  def edit
  end
end
