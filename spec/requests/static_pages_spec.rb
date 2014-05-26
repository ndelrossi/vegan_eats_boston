require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the content 'Vegan Eats Boston'" do
      visit '/static_pages/home'
      expect(page).to have_content('Vegan Eats Boston')
    end

    it "should have the base title" do
      visit '/static_pages/home'
      expect(page).to have_title("Vegan Eats Boston")
    end

    it "should not have a custom page title" do
      visit '/static_pages/home'
      expect(page).not_to have_title('| Home')
    end
  end

  describe "Places page" do

    it "should have the content 'Places'" do
      visit '/static_pages/places'
      expect(page).to have_content('Places')
    end

    it "should have the title 'Places'" do
      visit '/static_pages/places'
      expect(page).to have_title("Vegan Eats Boston | Places")
    end
  end

  describe "About page" do

    it "should have the content 'About Us'" do
      visit '/static_pages/about'
      expect(page).to have_content('About Us')
    end

    it "should have the title 'About Us'" do
      visit '/static_pages/about'
      expect(page).to have_title("Vegan Eats Boston | About Us")
    end
  end
end