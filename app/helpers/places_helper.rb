module PlacesHelper

  # acts_as_taggable_on has category_list but it does not work with .includes(:categories)
  def place_categories(place)
    place.categories.map{ |category| category.name }.join(", ")
  end
end