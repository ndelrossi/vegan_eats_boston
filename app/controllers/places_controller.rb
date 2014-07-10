class PlacesController < ApplicationController
  include ApplicationHelper
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  before_action :admin_user,  except: [:index, :show]
  before_action :get_place, only: [:show, :edit, :update, :destroy]

  def index
    @places = Place.all
    @places = @places.starts_with(params[:filter]) if params[:filter].present?

    if params[:search].present?
      @location = Geocoder.coordinates(params[:search])
      #@places = Place.near(@location, 50).paginate(page: params[:page], :per_page => 10)
    else
      #@places = Place.paginate(page: params[:page], :per_page => 10)
      @places = smart_listing_create :places, @places, partial: "places/listing",
                                        default_sort: {name: "asc"}
    end
    @hash = Gmaps4rails.build_markers(@places) do |place, marker|
      marker.lat place.latitude
      marker.lng place.longitude
    end
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
      params.require(:place).permit(:full_address, :name, :primary_image, :url_website, :url_menu, :address_line_1, :address_line_2, :address_city, :address_zip_code, :phone_number, :category_list)
    end

    def get_place
      @place = Place.find(params[:id])
    end
end