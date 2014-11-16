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

  def map_image_url
    "https://maps.googleapis.com/maps/api/staticmap?zoom=13"\
    "&size=350x180&markers=color:0x209600%7C"\
    "#{@place.address_line_1}+#{@place.address_city},MA"
  end
end
