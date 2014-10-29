require 'rails_helper'

describe User do

  describe "associations" do
    it { is_expected.to have_many(:posts).dependent(:destroy) }
    it { is_expected.to have_many(:reviews).dependent(:destroy) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to ensure_length_of(:name).is_at_most(50) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_confirmation_of(:password) }
    it { is_expected.to ensure_length_of(:password).is_at_least(6) }
    it { is_expected.to validate_attachment_content_type(:avatar).
                  allowing('image/png', 'image/gif', 'image/jpg').
                  rejecting('text/plain', 'text/xml') }

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

  describe "scopes" do
    it 'should have a default order of date descending' do
      create(:user, name: "one", created_at: 3.days.ago)
      create(:user, name: "two", created_at: 1.days.ago)
      create(:user, name: "three", created_at: 2.days.ago)
      expect(User.pluck(:name)).to eq(%w(two three one))
    end
  end

  describe "new" do
    subject { create(:inactive_user) }

    it { is_expected.to be_valid }
    it { is_expected.not_to be_active }
    it { is_expected.not_to be_admin }
    it { expect(:remember_token).to_not be_blank }

    it "saves the email as lowercase" do
      user = create(:user, email: "CASETEST@TEST.COM")
      user.save
      expect(user.email).to eq "casetest@test.com"
    end
  end

  describe "#send_password_reset" do
    let(:user) { create(:user) }

    before { user.send_password_reset }

    it "generates a unique password_reset_token each time" do  
      last_token = user.password_reset_token  
      user.send_password_reset  
      expect(user.password_reset_token).not_to eq(last_token)  
    end  
  
    it "saves the time the password reset was sent" do  
      expect(user.reload.password_reset_sent_at).to be_present  
    end  
  
    it "delivers email to user" do  
      last_email_recipient = ActionMailer::Base.deliveries.last.to
      expect(last_email_recipient).to eq ([user.email])  
    end  
  end

  describe "#send_activation" do
    let(:user) { create(:user) }

    before { user.send_activation }

    it "creates activation token" do  
      expect(user.activation_token).to be_present  
    end  
  
    it "delivers email to user" do  
      last_email_recipient = ActionMailer::Base.deliveries.last.to
      expect(last_email_recipient).to eq ([user.email])  
    end  
  end

  describe "#create_remember_token" do
    let(:user) { create(:user) }
    
    it "creates remember token" do
      user.remember_token = nil
      user.send(:create_remember_token)
      expect(user.remember_token).to be_present
    end
  end

  describe "#generate_token(column)" do
    let(:user) { create(:user) }

    it "generates a token" do
      user.password_reset_token = nil
      user.send(:generate_token, :password_reset_token)
      expect(user.password_reset_token).to be_present
    end
  end

  describe ".new_remember_token do" do
    it "returns a random token" do
      token = User.new_remember_token
      token2 = User.new_remember_token
      expect(token.length).to be >= 16
      expect(token).to_not eq (token2)
    end
  end

  describe ".digest" do
    it "returns digest of token" do
      token = "sdjfgal"
      digest = User.digest(token)
      expect(digest).to_not eq (token)
      expect(digest).to eq (User.digest("sdjfgal"))
    end
  end
end
