require 'rails_helper'

RSpec.describe User, type: :model do

  describe "Validations" do
    it "is valid" do
      user = User.new(
        name: "test",
        email: "test@123.com",
        password: "password",
        password_confirmation: "password"
      )
      expect(user).to be_valid
    end
    it "name presence" do
      user = User.new(
        name: nil,
        email: "test@123.com",
        password: "password",
        password_confirmation: "password"
      )
      user.valid?
      expect(user.errors.full_messages).to include("Name can't be blank")
    end
    it "email presence" do
      user = User.new(
        name: "test",
        email: nil,
        password: "password",
        password_confirmation: "password"
      )
      user.valid?
      expect(user.errors.full_messages).to include("Email can't be blank")
    end
    it "password presence" do
      user = User.new(
        name: "test",
        email: "test@123.com",
        password: nil,
        password_confirmation: "password"
      )
      user.valid?
      expect(user.errors.full_messages).to include("Password can't be blank")
    end
    it "password conf presence" do
      user = User.new(
        name: "test",
        email: "test@123.com",
        password: "password",
        password_confirmation: nil
      )
      user.valid?
      expect(user.errors.full_messages).to include("Password confirmation can't be blank")
    end
    it "password don't match" do
      user = User.new(
        name: "test",
        email: "test@123.com",
        password: "password",
        password_confirmation: "wordpass"
      )
      user.valid?
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it "email not unique" do
      user1 = User.create(
        name: "test",
        email: "test@123.com",
        password: "password",
        password_confirmation: "password"
      )
      user = User.new(
        name: "test1",
        email: "test@123.com",
        password: "password",
        password_confirmation: "password"
      )
      user.valid?
      expect(user.errors.full_messages).to include("Email has already been taken")
    end
    it "password too short, must be at least 6 chars" do
      user = User.new(
        name: "test",
        email: "test@123.com",
        password: "pass",
        password_confirmation: "pass"
      )
      user.valid?
      expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
  end

  describe ".authenticate_with_credentials" do
    it "succesfully authenticated" do
      user = User.new(
        name: "test1",
        email: "test@123.com",
        password: "password",
        password_confirmation: "password"
      )
      user.save
      user_session = User.authenticate_with_credentials("test@123.com", "password")
      expect(user_session).to be == user
    end
    
    it "not successfully authenticated" do
      user = User.new(
        name: "test1",
        email: "test@123.com",
        password: "password",
        password_confirmation: "password"
      )
      user.save
      user_session = User.authenticate_with_credentials("test@123.com", "wordpass")
      expect(user_session).to be == nil
    end

    it "authenticates user when there is space before or after the email" do
      user = User.new(
        name: "test1",
        email: "test@123.com",
        password: "password",
        password_confirmation: "password"
      )
      user.save
      user_session = User.authenticate_with_credentials("   test@123.com ", "password")
      expect(user_session).to be == user
    end

    it "authenticates and users if users type lower and upper case in email" do
      user = User.new(
        name: "test1",
        email: "test@123.com",
        password: "password",
        password_confirmation: "password"
      )
      user.save
      user_session = User.authenticate_with_credentials("tEsT@123.cOm", "password")
      expect(user_session).to be == user
    end
  end

end