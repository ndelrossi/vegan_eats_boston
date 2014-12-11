class Admin::PlacesController < AdminsController
  before_action :find_place, only: [:edit, :update, :destroy]

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

  def edit
  end

  def update
    respond_to do |format|
      if @place.update_attributes(place_params)
        format.html { flash[:success] = "Place updated"
                      redirect_to admin_dashboard_path }
        format.json { respond_with_bip(@place) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@place) }
      end
    end
  end

  def destroy
    @place.destroy
    flash[:success] = "Place deleted"
    redirect_to admin_dashboard_path
  end

  private

    def place_params
      params.require(:place).permit(:full_address, :name, :description, 
                                    :primary_image, :url_website, :url_menu, 
                                    :address_line_1, :address_line_2, 
                                    :address_city, :address_zip_code, 
                                    :phone_number, :category_list)
    end

    def find_place
      @place = Place.friendly.find(params[:id])
    end
end
