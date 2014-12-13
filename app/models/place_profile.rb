class PlaceProfile

  attr_reader :place

  def initialize(params, options = { reviews_per_page: 10 } )
    @params = params
    @reviews_per_page = options[:reviews_per_page]
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
    @place.reviews.page(@params[:page]).per(@reviews_per_page)
  end
end
