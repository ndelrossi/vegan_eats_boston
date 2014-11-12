module MapHelper

  def map_markers(places)

    counter = 1;
    @hash = Gmaps4rails.build_markers(places) do |place, marker|
      marker.lat place.latitude
      marker.lng place.longitude
      marker.picture({
       "url" => "/assets/map-icons/icon-#{counter}.png",
       "width" =>  32,
       "height" => 32})
      marker.title place.name
      marker.infowindow place.name
      counter += 1
    end

    return @hash
  end

end
