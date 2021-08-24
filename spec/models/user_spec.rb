require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    it 'validates all fields are required for signup and email is unique' do
      @user = User.create({first_name: "Bob", last_name: "Green", email: "bob.green@gmail.com", password: "abc123", password_confirmation: "abc123"})
      expect(@user.errors.full_messages).to eq []
      @user2 = User.create({first_name: "Bob", last_name: "Green", email: "BOB.green@gmail.com", password: "abc123", password_confirmation: "abc123"})
      expect(@user2.errors.full_messages).to include "Email has already been taken"
    end
    it 'validates there is a password and password_confirmation, and that they match' do
      @user = User.create({first_name: "Bob", last_name: "Green", email: "bob.green@gmail.com", password: "abc123"})
      expect(@user.errors.full_messages).to include "Password confirmation can't be blank"
      @user2 = User.create({first_name: "Bob", last_name: "Green", email: "bob.green@gmail.com", password: "abc123", password_confirmation: "abc321"})
      expect(@user2.errors.full_messages).to include "Password confirmation doesn't match Password"
    end
    it 'validates the password has a minimum length of 5 characters' do
      @user = User.create({first_name: "Bob", last_name: "Green", email: "bob.green@gmail.com", password: "abc", password_confirmation: "abc"})
      expect(@user.errors.full_messages).to include "Password is too short (minimum is 5 characters)"
    end
  end
  
  describe '.authenticate_with_credentials' do
    it 'returns the given user when the email and password match' do
      @user = User.create({first_name: "Bob", last_name: "Green", email: "bob.green@gmail.com", password: "abc123", password_confirmation: "abc123"})
      expect(@user.authenticate_with_credentials("bob.green@gmail.com", "abc123")).to eq @user
    end
    it 'returns nil when the email and password do not match' do
      @user = User.create({first_name: "Bob", last_name: "Green", email: "bob.green@gmail.com", password: "abc123", password_confirmation: "abc123"})
      expect(@user.authenticate_with_credentials("bob.green@gmail.com", "abc321")).to eq nil
    end
    it 'returns the given user when the email casing is wrong' do
      @user = User.create({first_name: "Bob", last_name: "Green", email: "BOB.green@gmail.com", password: "abc123", password_confirmation: "abc123"})
      expect(@user.authenticate_with_credentials("bOB.grEEn@gmail.COM", "abc123")).to eq @user
    end
    it 'returns the given user when whitespace is included' do
      @user = User.create({first_name: "Bob", last_name: "Green", email: "bob.green@gmail.com", password: "abc123", password_confirmation: "abc123"})
      expect(@user.authenticate_with_credentials("  bob.green@gmail.com  ", "abc123")).to eq @user
    end
  end
  
end
