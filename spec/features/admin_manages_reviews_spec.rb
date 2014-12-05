require 'rails_helper'

feature "Admin manages reviews" do
  let(:admin) { create(:admin) }
  let!(:review) { create(:review) }

  scenario "deleting a review" do
    sign_in admin
    visit_admin_reviews_page

    find(:xpath, "//a[@href='/reviews/#{review.id}']").click

    expect(page).to have_content("Review deleted")
    visit_admin_reviews_page
    expect(page).not_to have_xpath("//a[@href='/reviews/#{review.id}']")
  end

  scenario "editing a review" do
    sign_in admin
    visit_admin_reviews_page

    find(:xpath, "//a[@href='/reviews/#{review.id}/edit']").click
    fill_in "Content", with: "Updated review"
    click_button "Update review"

    expect(page).to have_content("Review updated")
    visit place_path(review.place)
    expect(page).to have_content("Updated review")
  end

  def visit_admin_reviews_page
    visit admin_dashboard_path
    click_link "Reviews"
  end
end
