class Admin::DashboardsController < AdminsController
  def index
    @posts = Post.page(params[:post_page]).per(10)
    @users = User.page(params[:user_page]).per(10)
    @places = Place.page(params[:place_page]).per(10)
    @reviews = Review.page(params[:review_page]).per(10)
  end
end
