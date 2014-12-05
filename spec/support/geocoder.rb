Geocoder.configure(:lookup => :test)

Geocoder::Lookup::Test.add_stub(
  "100 Mass Ave Cambridge, MA", [
    {
      'latitude'     => 42.360092,
      'longitude'    => -71.094495
    }
  ]
)
Geocoder::Lookup::Test.add_stub(
  "400 Mass Ave Cambridge, MA", [
    {
      'latitude'     => 42.363584,
      'longitude'    => -71.100269
    }
  ]
)
Geocoder::Lookup::Test.add_stub(
  "700 Mass Ave Cambridge, MA", [
    {
      'latitude'     => 42.366045,
      'longitude'    => -71.104475
    }
  ]
)
Geocoder::Lookup::Test.add_stub(
  "1000 Mass Ave Cambridge, MA", [
    {
      'latitude'     => 42.369016,
      'longitude'    => -71.110688
    }
  ]
)
