require 'rails_helper'

describe Review do

  before { allow_any_instance_of(Place).to receive(:geocode).and_return([1,1]) }

  it { is_expected.to belong_to(:user) } 
  it { is_expected.to belong_to(:place) } 
  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_presence_of(:place_id) }

  describe "scopes" do
    it 'should have a default order of date descending' do
      create(:review, content: "one", created_at: 3.days.ago)
      create(:review, content: "two", created_at: 1.days.ago)
      create(:review, content: "three", created_at: 2.days.ago)
      expect(Review.pluck(:content)).to eq(%w(two three one))
    end
  end

  describe "after_save" do
    it "should call 'update_place_method'" do
      review = create(:review)
      expect(review).to receive(:update_place_rating)
      review.save
    end
  end

  describe "#update_place_rating" do
    let(:place) { create(:place) }
    let(:review) { create(:review, place: place) }

    it "should call 'update_rating' on its associated place" do
      expect(place).to receive(:update_rating).twice      
      review.send(:update_place_rating)
    end
  end
end
