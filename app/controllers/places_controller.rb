class PlacesController < ApplicationController
  include ApplicationHelper
  include MapHelper
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  before_action :admin_user,  except: [:index, :show]
  before_action :get_place, only: [:show, :edit, :update, :destroy]

  def index
    @places = Place.all
    @tags = Place.category_counts

    if params[:location].present?
      @location = Geocoder.coordinates(params[:location])
      @places = Place.near(@location, 50)
    end

    @places = @places.tagged_with(params[:categories], :any => true) if params[:categories].present?

    filtering_params(params).each do |key, value|
      @places = @places.public_send(key, value) if value.present?
    end
    
    @places = smart_listing_create :places, @places, partial: "places/listing",
                                      default_sort: {rating: "DESC"}
    @hash = get_map_markers(@places)
  end

  def show
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

    def filtering_params(params)
      params.slice(:contains, :cities, :sort)
    end
end