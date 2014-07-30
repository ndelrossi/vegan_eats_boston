module MapHelper

  def get_map_markers(places)

    counter = 1;
    @hash = Gmaps4rails.build_markers(places) do |place, marker|
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

    return @hash
  end

end