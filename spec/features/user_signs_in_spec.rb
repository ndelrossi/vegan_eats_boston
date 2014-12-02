require 'rails_helper'

feature "User signs in" do
  scenario "with valid email and password" do
    user = create(:user, email: "user@example.com")     

    sign_in user

    expect(page).to have_title("Vegan Eats Boston | #{user.name}")
    expect(page).to have_content('Sign out')
  end

  scenario "with invalid email and password" do
    user = create(:user, email: "user@example.com")
    user.password = "wrongpassword"     

    sign_in user

    expect(page).to have_content('Invalid email/password combination')
    expect(page).to_not have_title("Vegan Eats Boston | #{user.name}")
  end
end
