# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  let(:password) { 'imawesome' }
  let(:email) { 'blah@blah.com' }
  subject(:user) do
    # User.new(
    #   email: email,
    #   password: password
    # )
    FactoryBot.build(
      :user,
      email: email,
      password: password
    )
  end
  
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_length_of(:password).is_at_least(6) }

  # it 'creates a password digest when a password is given' do
  #   expect(user.password_digest).to_not be_null
  # end

  it '#is_password? validates passwords' do
    expect(user.is_password?(password)).to be_truthy
  end

  it '#reset_session_token resets user token' do
    expect(user.session_token).to_not eq(user.reset_session_token!)
  end

  it 'finds a user by credentials' do
    user.save!
    expect(User.find_by_credentials(email, password)).to eq(user)
  end
end
