require 'rails_helper'

describe "Static pages" do

  subject { page }

  describe "Home page" do
    let!(:p1) { create(:post, title: "Title", content: "Foo", approved: true) }
    let!(:p2) { create(:post, title: "Title", content: "Bar", approved: true) }
    before { visit root_path }

    it { is_expected.to have_content('Vegan Eats Boston') }
    it { is_expected.to have_title(full_title('')) }
    it { is_expected.to_not have_title('| Home') }

    describe "posts" do
      
      it { is_expected.to have_content(p1.content) }
      it { is_expected.to have_content(p2.content) }
    end
  end

  describe "Places page" do
    before { visit places_path }

    it { is_expected.to have_content('Places') }
    it { is_expected.to have_title(full_title('Places')) }
  end

  describe "About page" do
    before { visit about_path }

    it { is_expected.to have_content('About') }
    it { is_expected.to have_title(full_title('About Us')) }
  end
end
