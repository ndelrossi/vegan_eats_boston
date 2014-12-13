require 'rails_helper'
include PlacesHelper

feature "visitor searches places" do
  let!(:place1) { create(:place, name:             "FooBarPlace",
                                 address_city:     "Cambridge",
                                 address_line_1:   "700 Mass Ave",
                                 address_zip_code: "02139") }

  let!(:place2) { create(:place, name:             "FooPlace",
                                 address_city:     "Cambridge",
                                 address_line_1:   "400 Mass Ave",
                                 address_zip_code: "02139") }

  let!(:place3) { create(:place, name:             "BarBazPlace",
                                 address_city:     "Cambridge",
                                 address_line_1:   "1000 Mass Ave",
                                 address_zip_code: "02139") }

  scenario "visitor searches with address" do
    visit root_path
    fill_in "search", with: "100 Mass Ave Cambridge, MA"
    click_button "search-submit"

    expect(page.text).to match(/FooPlace.*FooBarPlace.*BarBazPlace/)
  end
  
  scenario "vivisotr searches with name" do
    visit root_path
    fill_in "search", with: "Bar"
    click_button "search-submit"

    expect(page).to have_content("FooBarPlace")
    expect(page).to have_content("BarBazPlace")
    expect(page).not_to have_content("FooPlace")
  end
end
