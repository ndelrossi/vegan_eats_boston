module PlacesHelper

  # acts_as_taggable_on has category_list but it does not work with .includes(:categories)
  def place_categories(place)
    place.categories.map{ |category| category.name }.join(", ")
  end

  def map_image_for(place)
    image_tag "https://maps.googleapis.com/maps/api/staticmap?zoom=13"\
    "&size=350x180&markers=color:0x209600%7C"\
    "#{place.address_line_1}+#{place.address_city},MA"
  end
end
