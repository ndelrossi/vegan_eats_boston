require 'rails_helper'

describe Place do
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

    it "returns the average rating of all associated reviews" do
      create(:review, place: place, rating: 100)
      create(:review, place: place, rating: 50)
      place.update_rating
      expect(place.rating).to eq 75
    end
  end 
end
