require 'rails_helper'

feature "Visitor signs up" do
  scenario "visitor signs up from home page with valid info" do
    visit root_path
    click_link "Sign up now!"
    sign_up_with("Foo", "Foo@domain.com", "password", "password")
    expect(page).to have_content("Please follow the link in your email 
                                  to activate your account. You will not 
                                  be able to log in until you activate.")
  end

  def sign_up_with(name, email, password, confirm)
    fill_in "Name",         with: name
    fill_in "Email",        with: email
    fill_in "Password",     with: password
    fill_in "Confirmation", with: confirm
    click_button "Create my account"
  end
end

