module PlacesHelper

  # acts_as_taggable_on has category_list but it does not work with .includes(:categories)
  def place_categories(place)
    place.categories.map{ |category| category.name }.join(", ")
  end

  def full_address_to_html_for(place)
    if place.address_line_2.empty?
      line2 = ""
    else
      line2 = "#{place.address_line_2}<br>"
    end
    "#{place.address_line_1}<br>#{line2}#{place.address_city}, "\
    "#{place.address_state} #{place.address_zip_code}".html_safe
  end
end
