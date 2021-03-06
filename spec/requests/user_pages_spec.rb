require 'rails_helper'

describe "User pages" do

  subject { page }

  describe "profile page" do
    let(:admin) { FactoryGirl.create(:admin) }
    before do 
      sign_in admin
      visit user_path(admin)
    end

    it { is_expected.to have_content(admin.name) }
    it { is_expected.to have_title(admin.name) }
  end

  describe "signup page" do
    before { visit signup_path }

    it { is_expected.to have_content('Sign up') }
    it { is_expected.to have_title(full_title('Sign up')) }
  end

  describe "signup page" do
    before { visit signup_path }

    it { is_expected.to have_content('Sign up') }
    it { is_expected.to have_title(full_title('Sign up')) }
  end

  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { is_expected.to have_content("Update your profile") }
      it { is_expected.to have_title("Edit user") }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { is_expected.to have_content('error') }
    end

    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Name",                       with: new_name
        fill_in 'user_password',              with: user.password
        fill_in 'user_password_confirmation', with: user.password
        click_button "Save changes"
      end

      it { is_expected.to have_title(new_name) }
      it { is_expected.to have_selector('div.alert.alert-success') }
      it { is_expected.to have_link('Sign out', href: signout_path) }
      specify { expect(user.reload.name).to  eq new_name }
    end
  end
end
