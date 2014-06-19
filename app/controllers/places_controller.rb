class PlacesController < ApplicationController
  include ApplicationHelper
  before_action :admin_user,  except: [:index, :show]
  before_action :get_place, only: [:show, :edit, :update, :destroy]

  def index
    @places = Place.paginate(page: params[:page], :per_page => 10)
  end

  def show
    @place = Place.find(params[:id])
    #@review = Review.where(:place => @place, :user => current_user)
    @review = @place.reviews.build
    @reviews = Review.where(:place => @place).paginate(page: params[:page], :per_page => 10)
  end

  def new
    @place = Place.new
  end

  def create
    @place = Place.new(place_params)
    @place.address_state = 'MA'
    if @place.save
      flash[:success] = "Place created!"
      redirect_to @place
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @place.update_attributes(place_params)
      flash[:success] = "Place updated"
      redirect_to @place
    else
      render 'edit'
    end
  end

  def destroy
    @place.destroy
    redirect_to admin_path
  end

  private

    def place_params
      params.require(:place).permit(:name, :primary_image, :url_website, :url_menu, :address_line_1, :address_line_2, :address_city, :address_zip_code, :phone_number)
    end

    def get_place
      @place = Place.find(params[:id])
    end

end