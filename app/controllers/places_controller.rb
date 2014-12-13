class PlacesController < ApplicationController
  include ApplicationHelper
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  def index
    @places = Place.all
    if params[:search].present?
      @places = Place.near(coordinates, 50)
      if @places.empty?
        params[:contains] = params[:search]
        params[:search] = nil
        @places = Place.all
      end
    end
    @places = @places.filter(params.slice(:contains, :cities, :sort, :categories))

    @places = smart_listing_create :places, @places.includes(:categories), partial: "places/listing",
                                      default_sort: {id: "ASC"}
  end

  def show
    @profile = PlaceProfile.new(params, reviews_per_page: 10)
  end

  private

  def coordinates
    @location = Geocoder.coordinates(params[:search])
  end
end
