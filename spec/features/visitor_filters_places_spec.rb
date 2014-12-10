require 'rails_helper'

feature "Visitor filters places" do
  let!(:p1) { create(:place, name: "FooBiz", 
                             address_city: "Newton",
                             rating: 4) }
  let!(:p2) { create(:place, name: "Bar", 
                             address_city: "Cambridge",
                             rating: 5) }
  let!(:p3) { create(:place, name: "FooBaz", 
                             address_city: "Somerville",
                             rating: 2) }

  before do
    visit places_path
  end

  scenario "visitor filters by name", js: true do
    fill_in "contains", with: "Foo"

    expect(page).to have_content("FooBiz")
    expect(page).to have_content("FooBaz")
    expect(page).not_to have_content("Bar")
  end

  scenario "visitor sorts places by rating", js: true do
    click_button("Sort by")
    choose('sort_rating')  

    expect(page.text).to match(/Bar.*FooBiz.*FooBaz/)
  end
end
