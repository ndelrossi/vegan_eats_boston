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
end
