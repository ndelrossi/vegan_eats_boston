module ReviewsHelper

  def new_or_edit_review_path(place)
    review = current_user.reviews.find_by(place_id: place.id)
    if review
      edit_review_path(review)
    else  
      new_review_path(place_id: @place.id)
    end
  end
end
