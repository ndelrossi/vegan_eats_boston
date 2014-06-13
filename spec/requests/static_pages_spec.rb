require 'spec_helper'
require 'ruby-debug'

describe "Static pages" do

  subject { page }

  describe "Home page" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:p1) { FactoryGirl.create(:post, user: user, title: "Title", content: "Foo") }
    let!(:p2) { FactoryGirl.create(:post, user: user, title: "Title", content: "Bar") }
    before { visit root_path }

    it { should have_content('Vegan Eats Boston') }
    it { should have_title(full_title('')) }
    it { should_not have_title('| Home') }

    describe "posts" do
      
      it { should have_content(p1.content) }
      it { should have_content(p2.content) }
    end
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