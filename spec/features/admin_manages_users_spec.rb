require 'rails_helper'

feature "Admin manages users" do
  let(:admin) { create(:admin) }
  let!(:user) { create(:user, name: "UserFoo") }

  scenario "deleting a user" do
    sign_in admin
    visit_admin_users_page

    find(:xpath, "//a[@href='/admin/users/#{user.id}']").click

    expect(page).to have_content("User deleted.")
    visit_admin_users_page
    expect(page).not_to have_content("UserFoo")
  end

  scenario "editing a user" do
    sign_in admin
    visit_admin_users_page

    find(:xpath, "//a[@href='/users/#{user.id}/edit']").click
    fill_in "Name",                       with: "UserBar"
    fill_in "user_password",              with: "foobar"
    fill_in "user_password_confirmation", with: "foobar"
    click_button "Save changes"

    expect(page).to have_content("Profile updated")
    visit_admin_users_page
    expect(page).to have_content("UserBar")
    expect(page).not_to have_content("UserFoo")
  end

  def visit_admin_users_page
    visit admin_dashboard_path
    click_link "Users"
  end
end
