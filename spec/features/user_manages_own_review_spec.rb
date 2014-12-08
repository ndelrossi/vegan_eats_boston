require 'rails_helper'

feature "User manages own review" do
  let(:user) { create(:user) }
  before do
    sign_in user
  end

  scenario "user views own reviews on profile page" do
    review1 = create(:review, content: "Review1", user: user)
    review2 = create(:review, content: "Review2", user: user)

    visit user_path(user)

    expect(page).to have_content("Review1")
    expect(page).to have_content("Review2")
  end

  scenario "user deletes own review" do
    review = create(:review, content: "excellent", user: user)
    visit user_path(user)

    click_link "delete-review-#{review.id}"
    
    expect(page).to have_content("Review deleted")
    expect(page).not_to have_content("excellent")
  end

  scenario "user edits own review" do
    review = create(:review, content: "excellent", user: user)
    visit user_path(user)

    click_link "edit-review-#{review.id}"
    fill_in "Content", with: "awful"
    click_button "Update review"
    
    expect(page).to have_content("Review updated")
    expect(page).not_to have_content("excellent")
    expect(page).to have_content("awful")
  end
end

