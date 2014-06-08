require 'spec_helper'

describe Comment do

  let(:user) { FactoryGirl.create(:user) }
  let(:post) { FactoryGirl.create(:post) }
  before { @comment = post.comments.build(content: "Comment test", user: user ) }

  subject { @comment }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:post_id) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @comment.user_id = nil }
    it { should_not be_valid }
  end

  describe "when post_id is not present" do
    before { @comment.post_id = nil }
    it { should_not be_valid }
  end

end