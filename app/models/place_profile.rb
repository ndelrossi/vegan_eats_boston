class PlaceProfile

  attr_reader :place

  def initialize(params, options = { num_of_reviews: 10 } )
    @params = params
    @num_of_reviews = options[:num_of_reviews]
    @place = Place.friendly.find(@params[:id])
  end

  def name
    @place.name
  end

  def website
    @place.url_website
  end

  def menu
    @place.url_menu
  end

  def phone_number
    @place.phone_number
  end

  def categories
    @place.category_list
  end

  def reviews
    @place.reviews.page(@params[:page]).per(@num_of_reviews)
  end
end
