class UserProfile
  attr_reader :user

  def initialize(params)
    @user = User.includes(:posts, :reviews).find(params[:id])
    @post_page = params[:post_page]
    @review_page = params[:review_page]
  end

  def name
    @user.name
  end

  def admin?
    @user.admin?
  end

  def posts
    @user.posts.page(@post_page).per(6)
  end

  def reviews
    @user.reviews.includes(:place).page(@review_page).per(6)
  end

end
