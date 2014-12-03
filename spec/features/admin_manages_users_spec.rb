require 'rails_helper'

feature "Admin manages users" do
  scenario "deleting a user" do
    admin = create(:admin)
    user = create(:user, name: "UserFoo")

    sign_in admin
    visit_admin_users
    find(:xpath, "//a[@href='/admin/users/#{user.id}']").click

    expect(page).to have_content("User deleted.")
    visit_admin_users
    expect(page).not_to have_content("UserFoo")
  end

  scenario "editing a user" do
    admin = create(:admin)
    user = create(:user, name: "UserFoo")

    sign_in admin
    visit_admin_users
    find(:xpath, "//a[@href='/users/#{user.id}/edit']").click
    fill_in "Name",                       with: "UserBar"
    fill_in "user_password",              with: "foobar"
    fill_in "user_password_confirmation", with: "foobar"
    click_button "Save changes"

    expect(page).to have_content("Profile updated")
    visit_admin_users
    expect(page).to have_content("UserBar")
    expect(page).not_to have_content("UserFoo")
  end

  def visit_admin_users
    visit admin_dashboard_path
    click_link "Users"
  end
end
