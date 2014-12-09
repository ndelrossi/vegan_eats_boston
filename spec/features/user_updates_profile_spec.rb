require 'rails_helper'

feature "User updates profile" do
  let(:user) { create(:user) }
  before do
    sign_in user
    visit root_path
    first(:link, "Settings").click
  end

  scenario "user updates name" do
    fill_in "Name",                       with: "NewName"
    fill_in "user_password",              with: "password"
    fill_in "user_password_confirmation", with: "password"
    click_button "Save changes"

    expect(page).to have_content("Profile updated")
    expect(page).to have_content("NewName")
  end

  scenario "user updates profile image" do
    fill_in "user_password",              with: "password"
    fill_in "user_password_confirmation", with: "password"
    attach_file "Profile Image", "spec/support/uploads/new_image.jpg"
    click_button "Save changes"

    expect(page).to have_content("Profile updated")
    expect(page).to have_xpath("//img[contains(@src, \"new_image.jpg\")]")
  end

  scenario "user tries to change name without re-entering password" do
    fill_in "Name",                       with: "NewName"
    click_button "Save changes"

    expect(page).not_to have_content("Profile updated")
    expect(page).to have_content("Password is too short")
  end
end
