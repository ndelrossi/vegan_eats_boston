require 'rails_helper'

feature "User signs out" do
  scenario "using nav drop-down" do
    user = create(:user)
    sign_in user

    visit user_path(user)
    first(:link, "Sign out").click

    expect(page).to have_content("Sign in")
    expect(page).not_to have_content("Sign out")
  end
end
