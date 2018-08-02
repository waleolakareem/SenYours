require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { @user = create(:user) }

  describe "attributes" do
    it "has a first name" do
      expect(user.first_name).to eq("Test")
    end

    it "has a last_name" do
      expect(user.last_name).to eq "User"
    end

    it "has an email" do
      expect(user.email).to eq "test_user@gmail.com"
    end
  end

  describe "validations" do
    it "is valid with an email" do
      expect(user).to be_valid
    end

    it "is invalid without an email" do
      user.email = nil
      expect(user).to be_invalid
    end

    it "is valid with a password" do
      expect(user).to be_valid
    end

    it "is invalid without a password" do
      user.password = nil
      expect(user).to be_invalid
    end

    it "validates that user must be over 18" do
      user.dob = "2018-01-02"
      expect(user).to be_invalid
    end

    it "is valid with a phone number" do
      expect(user).to be_valid
    end
  end
end
