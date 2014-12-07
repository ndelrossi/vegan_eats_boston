require 'rails_helper'

feature "User writes review" do
  let(:user) { create(:user) }
  let(:place) { create(:place) }

  before do
    sign_in user
    visit place_path(place)
    click_link "Write review"
  end

  scenario "user writes valid review" do
    find(:xpath, "//input[@id='rating']").set 4
    fill_in "Content", with: "Very foo place"
    click_button "Publish review"

    expect(page).to have_content("Review created!")
    expect(page).to have_content("Very foo place")
    expect(page.html).to match(/score:\s4/)
  end

  scenario "user tries to create review without a rating" do
    fill_in "Content", with: "Very foo place"
    click_button "Publish review"

    expect(page).to have_content("Rating can't be blank")
  end

  scenario "user attempts to write two reviews" do
    visit new_review_path(place_id: place.id)
    find(:xpath, "//input[@id='rating']").set 3
    fill_in "Content", with: "first review"
    click_button "Publish review"

    visit new_review_path(place_id: place.id)
    find(:xpath, "//input[@id='rating']").set 4
    fill_in "Content", with: "Second review"
    click_button "Publish review"

    expect(page).to have_content("You can only have one review per place")
  end
end
