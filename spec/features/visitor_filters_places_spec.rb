require 'rails_helper'

feature "Visitor filters places" do
  let!(:p1) { create(:place, name: "FooBiz", 
                             address_city: "Newton",
                             category_list: "Pizza",
                             rating: 4) }
  let!(:p2) { create(:place, name: "Bar", 
                             address_city: "Cambridge",
                             category_list: "Pizza",
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
    wait_for_ajax

    expect(page.text).to match(/Bar.*FooBiz.*FooBaz/)
  end

  scenario "visitor sorts places by name", js: true do
    click_button("Sort by")
    choose('sort_name')  
    wait_for_ajax

    expect(page.text).to match(/Bar.*FooBaz.*FooBiz/)
  end

  scenario "visitor filters places by selecting cities", js: true do
    click_button("Cities")
    find(:css, "#cities_[value='Somerville']").set(true)
    find(:css, "#cities_[value='Cambridge']").set(true)
    wait_for_ajax

    expect(page).to have_content("FooBaz")
    expect(page).to have_content("Bar")
    expect(page).not_to have_content("FooBiz")
  end

  scenario "visitor filters places by selecting categories", js: true do
    click_button("Categories")
    find(:css, "#categories_[value='Pizza']").set(true)
    wait_for_ajax

    expect(page).to have_content("FooBiz")
    expect(page).to have_content("Bar")
    expect(page).not_to have_content("FooBaz")
  end

  scenario "visitor filters places by category and city and sorts by rating", js: true do
    click_button("Sort by")
    choose('sort_rating')  
    find("#categories_button").trigger("click")
    find(:css, "#categories_[value='Pizza']").set(true)
    find("#cities_button").trigger("click")
    find(:css, "#cities_[value='Cambridge']").set(true)
    find(:css, "#cities_[value='Newton']").set(true)
    wait_for_ajax

    expect(page.text).to match(/Bar.*FooBiz/)
  end
end
