require 'spec_helper'

describe "Static pages" do

  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_content('Vegan Eats Boston') }
    it { should have_title(full_title('')) }
    it { should_not have_title('| Home') }
  end

  describe "Places page" do
    before { visit places_path }

    it { should have_content('Places') }
    it { should have_title(full_title('Places')) }
  end

  describe "About page" do
    before { visit about_path }

    it { should have_content('About') }
    it { should have_title(full_title('About Us')) }
  end
end