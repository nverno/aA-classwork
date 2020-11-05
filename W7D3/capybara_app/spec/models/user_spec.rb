# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'rails_helper'

RSpec.describe User, type: :model do
  let(:username) {'Rizza'}
  let(:password) {'password'}
  subject(:user) {User.create!(username: username, password: password)}
  describe 'validations' do
    # all columns should be present
    # uniqueness for username & session_token
    # password length needs to >= 7
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:session_token) }
    it { should validate_presence_of(:password_digest) }

    it { should validate_uniqueness_of(:username) }
    it { should validate_uniqueness_of(:session_token) }

    it { should validate_length_of(:password).is_at_least(7) }
  end

  # describe 'associations' do

  # end

  describe '::find_by_credentials' do
    # { username => username, ... }
    # (usernae, pass.) (options)
    before(:each) {user.save}
    it "finds the proper credentials" do
      expect(User.find_by_credentials(username, password)).to eq(user)
    end
  end

  describe '#is_password?' do
    context 'with valid password' do
      it 'should return true' do
        expect(user.is_password?(password)).to be_truthy
      end
    end

    context 'with invalid password' do
      it 'should return false' do
        expect(user.is_password?('durian')).to be_falsy
      end
    end
  end

  describe '#reset_session_token' do
    it 'not have the same token as it started with' do
      # create session token
      # ensure it changes
      expect(user.session_token).to_not eq(user.reset_session_token)
    end
  end
end
