require 'rails_helper'

describe User do

  before do
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end
  
  describe "associations" do
    it { is_expected.to have_many(:posts) }
    it { is_expected.to have_many(:reviews) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to ensure_length_of(:name).is_at_most(50) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_confirmation_of(:password) }
    it { is_expected.to ensure_length_of(:password).is_at_least(6) }

    context "email" do
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_uniqueness_of(:email) }

      it "rejects bad email addresses" do
        addresses = %w[user@foo,com user.org ex.user@foo. 
                        foo@bar_baz.com foo@bar+baz.com]
        addresses.each do |invalid_address|
          user = build(:user, email: invalid_address)
          expect(user).not_to be_valid
        end
      end

      it "accepts good email addresses" do
        addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
        addresses.each do |valid_address|
          user = build(:user, email: valid_address)
          expect(user).to be_valid
        end
      end
    end
  end

  describe "admin status" do
    context "without admin attribute set to 'true'" do
      it "should not be an admin" do
        user = create(:user)
        expect(user).not_to be_admin
      end
    end
    
    context "with admin attribute set to 'true'" do
      it "should be admin" do
        admin = create(:user, admin: true)
        expect(admin).to be_admin
      end
    end
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      it { user_for_invalid_password.should be_falsey }
    end
  end

  describe "remember token" do
    before { @user.save }
    it "to not be blank" do
      expect(:remember_token).to_not be_blank
    end
  end

  describe "post associations" do

    before { @user.save }
    let!(:older_post) do
      FactoryGirl.create(:post, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_post) do
      FactoryGirl.create(:post, user: @user, created_at: 1.hour.ago)
    end

    it "should have the right posts in the right order" do
      expect(@user.posts.to_a).to eq [newer_post, older_post]
    end

    it "should destroy associated posts" do
      posts = @user.posts.to_a
      @user.destroy
      expect(posts).not_to be_empty
      posts.each do |post|
        expect(Post.where(id: post.id)).to be_empty
      end
    end
  end
end
