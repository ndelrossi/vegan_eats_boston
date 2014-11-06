class ReviewsController < ApplicationController
  before_action :correct_user,   only: [:destroy, :edit, :update]

  def index
    @reviews = Review.page(params[:page])
  end

  def new
    @place = Place.find(params[:place])
    @review = Review.new
  end
  
  def create
    @review = current_user.reviews.new(reviews_params)
    if @review.save
      flash[:success] = "Review created!"
      redirect_to place_url(@review.place)
    else
      redirect_to signin_path
    end
  end

  def edit
  end

  def update
    if @review.update_attributes(reviews_params)
      flash[:success] = "Review updated!"
      redirect_to place_url(@review.place)
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
      @review = current_user.reviews.find_by(id: params[:id])
      redirect_to root_url if @review.nil?
    end
end
