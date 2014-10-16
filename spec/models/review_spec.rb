require 'rails_helper'

describe Review do
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
end
