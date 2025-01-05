class Seller::Base < ApplicationController
  before_action :seller_login_required

  private def seller_login_required
    raise Forbidden unless current_user.seller?
  end
end