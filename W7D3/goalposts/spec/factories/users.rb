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
FactoryBot.define do
  factory :user do
    username { Faker::Name.name }
    password { Faker::Internet.password(min_length: 6) }
    # password_digest { 'MyString' }
    # session_token { 'MyString' }
  end
end