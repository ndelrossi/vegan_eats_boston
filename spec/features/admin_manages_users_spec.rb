require 'rails_helper'

feature "Admin manages users" do
  scenario "with non-admin account" do
    user = create(:user)

    sign_in user
    visit admin_dashboard_path

    expect(page).to have_content('You are not authorized to view that page.')
    expect(page).not_to have_content('Admin Dashboard')
  end
  
  scenario "deleting a user" do
    admin = create(:admin)
    user = create(:user, name: "UserFoo")

    sign_in admin
    visit_admin_users
    expect(page).to have_content("UserFoo")

    find(:xpath, "//a[@href='/admin/users/#{user.id}']").click
    visit_admin_users
    expect(page).not_to have_content("UserFoo")
  end

  def visit_admin_users
    visit admin_dashboard_path
    click_link "Users"
  end
end
