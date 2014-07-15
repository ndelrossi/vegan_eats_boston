class PlacesController < ApplicationController
  include ApplicationHelper
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  before_action :admin_user,  except: [:index, :show]
  before_action :get_place, only: [:show, :edit, :update, :destroy]

  def index
    @places = Place.all
    @tags = Place.category_counts

    if params[:search].present?
      @location = Geocoder.coordinates(params[:search])
      @places = Place.near(@location, 50)
    end

    @places = @places.contains(params[:filter]) if params[:filter].present?
    @places = @places.cities(params[:cities]) if params[:cities].present?
    @places = @places.tagged_with(params[:categories], :any => true) if params[:categories].present?

    if params[:sort].present?
      if params[:sort] == "rating"
        @places = @places.order("rating DESC")
      else
        @places = @places.order(params[:sort])
      end
    end
    
    @places = smart_listing_create :places, @places, partial: "places/listing",
                                      default_sort: {name: "asc"}

    counter = 1;
    @hash = Gmaps4rails.build_markers(@places) do |place, marker|
      marker.lat place.latitude
      marker.lng place.longitude
      marker.picture({
       "url" => "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=#{counter}|209600|000000",
       "width" =>  32,
       "height" => 32})
      marker.title place.name
      marker.infowindow place.name
      counter += 1
    end
  end

  def show
    @place = Place.find(params[:id])
    @review = @place.reviews.build
    @reviews = Review.where(:place => @place).page(params[:page]).per(10)
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