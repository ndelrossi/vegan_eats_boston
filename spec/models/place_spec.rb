require 'spec_helper'

describe Place do

  before do
    @place = Place.new(name: "Example Place", 
                      url_website: "www.exampleplace.com",
                      url_menu: "www.exampleplace.com/menu",
                      address_line_1: "11 Example Ave",
                      address_line_2: "Floor 2",
                      address_city: "Boston",
                      address_state: "MA",
                      address_zip_code: "02108",
                      phone_number: "555-555-5555")
  end

  subject { @place }

  it { should respond_to(:name) }
  it { should respond_to(:url_website) }
  it { should respond_to(:url_menu) }
  it { should respond_to(:address_line_1) }
  it { should respond_to(:address_line_2) }
  it { should respond_to(:address_city) }
  it { should respond_to(:address_state) }
  it { should respond_to(:address_zip_code) }
  it { should respond_to(:phone_number) }
end