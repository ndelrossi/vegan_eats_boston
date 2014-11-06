module ReviewsHelper

  def new_or_edit_review_path(place)
    if current_user.reviews.find_by(place_id: place.id)
      edit_review_path(place)
    else  
      new_review_path(place)
    end
  end
end
