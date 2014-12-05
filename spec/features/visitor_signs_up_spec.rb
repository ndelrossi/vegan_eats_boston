require 'rails_helper'

feature "Visitor signs up" do
  scenario "visitor signs up from home page with valid info" do
    visit root_path
    click_link "Sign up now!"

    sign_up_with("Foo", "Foo@domain.com", "password", "password")

    expect(page).to have_content("Please follow the link in your email")
  end

  scenario "visitor tries to sign up with no info" do
    visit signup_path

    sign_up_with()

    expect(page).to have_content("The form contains 5 errors.")
  end

  scenario "visitor tries to sign up with already taken email" do
    user = create(:user, email: "Foo@domain.com")
    visit signup_path

    sign_up_with("Foo", "Foo@domain.com", "password", "password")

    expect(page).to have_content("Email has already been taken")
  end

  scenario "visitor tries to sign up with passwords that don't match" do
    visit signup_path

    sign_up_with("Foo", "Foo@domain.com", "password", "spaghetti")

    expect(page).to have_content("Password confirmation doesn't match Password")
  end

  scenario "visitor tries to sign up with blank name" do
    visit signup_path

    sign_up_with("", "Foo@domain.com", "password", "password")

    expect(page).to have_content("Name can't be blank")
  end

  scenario "visitor tries to sign up with blank email" do
    visit signup_path

    sign_up_with("Foo", "", "password", "password")

    expect(page).to have_content("Email can't be blank")
  end

  scenario "visitor tries to sign up with password that is too short" do
    visit signup_path

    sign_up_with("Foo", "Foo@domain.com", "pw", "pw")

    expect(page).to have_content("Password is too short")
  end

  scenario "visitor tries to sign up with invalid email" do
    visit signup_path

    sign_up_with("Foo", "Foo@doma@in.co.m", "password", "password")

    expect(page).to have_content("Email is invalid")
  end

  def sign_up_with(name="", email="", password="", confirm="")
    fill_in "Name",         with: name
    fill_in "Email",        with: email
    fill_in "Password",     with: password
    fill_in "Confirmation", with: confirm
    click_button "Create my account"
  end
end

