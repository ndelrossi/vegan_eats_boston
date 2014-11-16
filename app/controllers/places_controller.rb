class PlacesController < ApplicationController
  include ApplicationHelper
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  def index
    @places = Place.all

    if params[:search].present?
      @location = Geocoder.coordinates(params[:search])
      @places = Place.near(@location, 50)
      
      #Couldnt find address, search by name
      if @places.empty?
        params[:contains] = params[:search]
        params[:search] = nil
        @places = Place.all
      end
    end

    @places = @places.tagged_with(params[:categories], :any => true) if params[:categories].present?

    filtering_params(params).each do |key, value|
      @places = @places.public_send(key, value) if value.present?
    end

    @places = smart_listing_create :places, @places.includes(:categories), partial: "places/listing",
                                      default_sort: {id: "ASC"}
  end

  def show
    @place_profile = PlaceProfile.new(params, num_of_reviews: 10)
  end

private

  def filtering_params(params)
    params.slice(:contains, :cities, :sort)
  end
end
