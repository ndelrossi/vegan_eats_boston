require 'rails_helper'

feature "visitor searches places" do
  scenario "with address" do
    place1 = create(:place, name:             "Place1",
                            address_city:     "Cambridge",
                            address_line_1:   "700 Mass Ave",
                            address_zip_code: "02139")

    place2 = create(:place, name:             "Place2",
                            address_city:     "Cambridge",
                            address_line_1:   "400 Mass Ave",
                            address_zip_code: "02139")

    place3 = create(:place, name:             "Place3",
                            address_city:     "Cambridge",
                            address_line_1:   "1000 Mass Ave",
                            address_zip_code: "02139")

    visit root_path
    fill_in "search", with: "100 Mass Ave Cambridge, MA"
    click_button "search-submit"

    expect(page.text).to match(/Place2.*Place1.*Place3/)
  end
end
