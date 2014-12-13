require 'rails_helper'

describe Place do

  before { allow_any_instance_of(Place).to receive(:geocode).and_return([1,1]) }

  it { is_expected.to have_many(:reviews).dependent(:destroy) }
  it { is_expected.to validate_attachment_content_type(:primary_image).
                allowing('image/png', 'image/gif', 'image/jpg').
                rejecting('text/plain', 'text/xml') }

  describe "scopes" do
    describe "contains" do
      it "returns all places that contain a string" do
        create(:place, name: "Foo bar")
        create(:place, name: "foo bar baz")
        create(:place, name: "foobarbaz")
        expect(Place.contains("foo bar").pluck(:name)).to eq ["Foo bar", "foo bar baz"]
      end
    end

    describe "cities" do
      it "returns all places with provided cities" do
        create(:place, name: "one", address_city: "Boston")
        create(:place, name: "two", address_city: "Somerville")
        expect(Place.cities(["Boston", "Newton"]).pluck(:name)).to eq ["one"]
      end
    end

    describe "categories" do
      it "returns all places with provided categories" do
        create(:place, name: "one", category_list: "Pizza")
        create(:place, name: "two", category_list: "Smoothies")
        expect(Place.categories(["Pizza", "Indian"]).pluck(:name)).to eq ["one"]
      end
    end

    describe "sort" do
      context "with sort set to 'rating'" do
        it 'orders by rating descending' do
          create(:place, name: "one", rating: 75)
          create(:place, name: "two", rating: 100)
          create(:place, name: "three", rating: 50)
          expect(Place.sort(sort = 'rating').pluck(:name)).to eq(%w(two one three))
        end
      end

      context "with sort set to 'name'" do
        it 'orders by name ascending' do
          create(:place, name: "b")
          create(:place, name: "a")
          create(:place, name: "c")
          expect(Place.sort(sort = 'name').pluck(:name)).to eq(%w(a b c))
        end
      end 
    end

    describe "highest_rated" do
      it 'orders by rating descending' do
        create(:place, name: "one", rating: 75)
        create(:place, name: "two", rating: 100)
        create(:place, name: "three", rating: 50)
        expect(Place.sort(sort = 'rating').pluck(:name)).to eq(%w(two one three))
      end
    end
  end
  
  describe "#full_address" do
    let(:place) { create(:place, address_line_1: "100 Foo Ave", 
        address_city: "Bar", address_state: "MA") }

    it "returns the full address string" do
      expect(place.full_address).to eq "100 Foo Ave Bar, MA"
    end
  end

  describe "#update_rating" do
    let(:place) { create(:place) }

    it "updates average rating of all associated reviews" do
      create(:review, place: place, rating: 5)
      create(:review, place: place, rating: 4)
      place.update_rating
      expect(place.rating).to eq 4.5
    end
  end 

  describe ".all_cities" do
    it "returns a unique list of all cities used" do
      create(:place, address_city: "Boston") 
      create(:place, address_city: "Newton")
      expect(Place.all_cities).to eq ["Boston", "Newton"]   
    end
  end

  describe ".strip_url" do
    it "removes http/https from url" do
      urls = ["https://www.test.com", "www.test.com", "http://www.test.com"]
      stripped_urls = urls.map { |url| Place.send(:strip_url, url) }
      expect(stripped_urls).to eq ["www.test.com", "www.test.com", "www.test.com"]
    end
  end
end
