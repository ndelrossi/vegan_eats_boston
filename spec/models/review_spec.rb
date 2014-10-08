require 'spec_helper'

describe Review do

  let(:user) { FactoryGirl.create(:user) }
  let(:place) { FactoryGirl.create(:place) }
  before do
    @review = Review.new(content: "This is a review", rating: 80, user_id: user.id, place_id: place.id)
  end

  subject { @review }

  it { should respond_to(:content) }
  it { should respond_to(:rating) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  it { should respond_to(:place_id) }
  it { should respond_to(:place) }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @review.user_id = nil }
    it { should_not be_valid }
  end

  describe "when place_id is not present" do
    before { @review.place_id = nil }
    it { should_not be_valid }
  end
end