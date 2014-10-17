module ReviewsHelper

  def new_or_edit_review_path(place)
    current_user.reviews.find_by(place_id: place.id) ? 
      edit_review_path(:place_id => place.id) : new_review_path(:place_id => place.id)
  end
end
