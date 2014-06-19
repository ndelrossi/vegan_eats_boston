class ReviewsController < ApplicationController
  before_action :correct_user,   only: [:destroy, :edit, :update]

  def index
    @reviews = Review.paginate(page: params[:page])
  end

  def create
    @place = Place.find(params[:review][:place_id])
    @review = @place.reviews.build(reviews_params)
    @review.user = current_user
    if @review.save
      flash[:success] = "Review created!"
      redirect_to place_url(@place)
    else
      redirect_to signin_path
    end
  end

  def edit
  end

  def update
    if @review.update_attributes(reviews_params)
      flash[:success] = "Review updated"
      redirect_to @review.place
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
      params.require(:review).permit(:content, :rating)
    end

    def correct_user
      @review = current_user.reviews.find_by(id: params[:id])
      if current_user.admin?
        @review ||= Review.find(params[:id])
      end
      redirect_to root_url if @review.nil?
    end
end