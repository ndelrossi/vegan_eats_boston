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

  def primary_image_for(place)
    image_tag place.primary_image.url
  end

  def editable_description_for(place)
    best_in_place_if signed_in? && current_user.admin?,
      place, 
      :description, 
      :path => admin_place_path(place), 
      :type => :textarea, 
      :nil => "Click here to add description."
  end

  def write_review_button_for(place)
    if signed_in?
      link_to "Write review", 
        new_or_edit_review_path(place), 
        class: "btn btn-default"
    end
  end

  def distance_between(place, location)
    "(" + place.distance_from(location).round(2).to_s + " miles)"
  end

  def filtered_results_text(count, params)
    result = "#{count} results"
    if params[:search].present?
      result += " for: " + params[:search].to_s
    elsif params[:contains].present?
      result += " for: " + params[:contains].to_s
    end
    result
  end
end
