class ReviewsController < ApplicationController
  before_action :correct_user,   only: [:destroy, :edit, :update]

  def index
    @reviews = Review.page(params[:page])
  end

  def new
    @place = Place.find(params[:id])
    @review = Review.new
  end
  
  def create
    @place = Place.find(params[:review][:place_id])
    @review = @place.reviews.build(reviews_params)
    @review.user = current_user
    @place.update_attributes(:rating => @place.get_average_rating)
    if @review.save
      flash[:success] = "Review created!"
      redirect_to place_url(@place)
    else
      redirect_to signin_path
    end
  end

  def edit
    @place = Place.find(params[:id])
  end

  def update
    @place = Place.find(params[:review][:place_id])
    @place.update_attributes(:rating => @place.get_average_rating)
    if @review.update_attributes(reviews_params)
      flash[:success] = "Review updated!"
      redirect_to place_url(@place)
    else
      render 'edit'
    end
  end

  def destroy
    @review.destroy
    redirect_to root_url
  end

  private

    def reviews_params
      params.require(:review).permit(:content, :rating, :place_id)
    end

    def correct_user
      @review = current_user.reviews.find_by(place_id: params[:id]) ||
        Review.find(params[:id])
      #if current_user.admin?
      #  @review ||= Review.find_by(place_id: params[:id])
      #end
      redirect_to root_url if @review.nil?
    end
end
