class PlacesController < ApplicationController
  include ApplicationHelper
  before_action :admin_user,  except: [:index, :show]

  def index
  end

  def show
    @place = Place.find(params[:id])
  end

  def new
    @place = Place.new
  end

  def create
    @place = Place.new(place_params)
    if @place.save
      flash[:success] = "Place created!"
      redirect_to @place
    else
      render 'new'
    end
  end

  private

    def place_params
      params.require(:place).permit(:name, :url_website, :url_menu, :address_line_1, :address_line_2, :address_city, :address_state, :address_zip_code, :phone_number)
    end

end