require 'rails_helper'

feature "Admin manages places" do
  let(:admin) { create(:admin) }
  let!(:place) { create(:place, name: "FooPlace") }

  scenario "deleting a place" do
    sign_in admin
    visit_admin_places_page

    find(:xpath, "//a[@href='/admin/places/#{place.friendly_id}']").click

    expect(page).to have_content("Place deleted")
    click_link "admin-places"
    expect(page).not_to have_content("FooPlace")
  end

  scenario "editing a place" do
    sign_in admin
    visit_admin_places_page

    find(:xpath, "//a[@href='/admin/places/#{place.friendly_id}/edit']").click
    fill_in "place_name", with: "BarPlace"
    click_button "Update place"

    expect(page).to have_content("Place updated")
    click_link "admin-places"
    expect(page).to have_content("BarPlace")
  end

  def visit_admin_places_page
    visit admin_dashboard_path
    click_link "admin-places"
  end
end
