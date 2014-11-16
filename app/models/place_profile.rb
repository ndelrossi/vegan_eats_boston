class PlaceProfile

  attr_reader :place

  def initialize(params, options = { num_of_reviews: 10 } )
    @params = params
    @num_of_reviews = options[:num_of_reviews]
    @place = Place.find(@params[:id])
  end

  def reviews
    @place.reviews.page(@params[:page]).per(@num_of_reviews)
  end

  def map_image

  end
end
