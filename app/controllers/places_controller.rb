class PlacesController < ApplicationController
  include ApplicationHelper
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  def index
    @places = Place.all
    
    #if params[:search].present?
    #  @places = Place.near(geolocation_for(params[:search]), 50)
    #  
      #Couldnt find address, search by name
    #  if @places.empty?
    #    params[:contains] = params[:search]
    #    params[:search] = nil
    #    @places = Place.all
    #  end
    #end

    @places = @places.filter(params.slice(:search, :contains, :cities, :sort, :categories))

    @places = smart_listing_create :places, @places.includes(:categories), partial: "places/listing",
                                      default_sort: {id: "ASC"}
  end

  def show
    @profile = PlaceProfile.new(params, num_of_reviews: 10)
  end
end
