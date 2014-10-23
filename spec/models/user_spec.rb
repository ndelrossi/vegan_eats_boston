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

  describe "new" do
    subject { create(:inactive_user) }

    it { is_expected.to be_valid }
    it { is_expected.not_to be_active }
    it { is_expected.not_to be_admin }
    it { expect(:remember_token).to_not be_blank }
  end
end
