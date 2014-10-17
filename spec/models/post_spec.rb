require 'rails_helper'

describe Post do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to ensure_length_of(:title).is_at_most(80) }
  it { is_expected.to validate_presence_of(:content) }
  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_attachment_content_type(:image).
                allowing('image/png', 'image/gif', 'image/jpg').
                rejecting('text/plain', 'text/xml') }

  describe "scopes" do
    it 'should have a default order of date descending' do
      create(:post, title: "one", created_at: 3.days.ago)
      create(:post, title: "two", created_at: 1.days.ago)
      create(:post, title: "three", created_at: 2.days.ago)
      expect(Post.pluck(:title)).to eq(%w(two three one))
    end
  end
end
