class AdminDashboard

  def initialize(params, options = { num_per_page: 10 } )
    @params = params
    @num_per_page = options[:num_per_page]
  end

  def users
    @users = User.page(@params[:user_page]).per(@num_per_page)
  end

  def places
    @places = Place.page(@params[:place_page]).per(@num_per_page)
  end

  def posts
    @posts = Post.page(@params[:post_page]).per(@num_per_page)
  end

  def reviews
    @reviews = Review.page(@params[:review_page]).per(@num_per_page)
  end
end
