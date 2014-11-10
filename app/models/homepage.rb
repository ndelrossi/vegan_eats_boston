class Homepage

  def initialize(params = {})
    @params = params
  end

  def posts
    Post.approved.page(@params[:page]).per(5)
  end

  def top_places
    Place.highest_rated.limit(5)
  end

  def recent_reviews
    Review.limit(3)
  end

end

