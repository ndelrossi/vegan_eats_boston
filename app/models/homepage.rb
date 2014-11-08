class Homepage

  def initialize(params = {})
    @params = params
  end

  def posts
    Post.includes(:user).where(:approved => true).page(@params[:page]).per(5)
  end

  def top_places
    Place.includes(:categories).order( 'rating DESC' ).limit(5)
  end

  def recent_reviews
    Review.order( 'created_at DESC' ).limit(3)
  end

end

