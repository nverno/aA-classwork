# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  attr_reader :password
  validates :username, :password_digest, presence: true
  validates :password, length: { minimum: 6 }, allow_nil: true

  has_many :cats,
           foreign_key: :user_id,
           class_name: :Cat

  has_many :requesters,
           foreign_key: :user_id,
           class_name: 'CatRentalRequest'

  has_many :sessions

  def reset_session_token(token)
    sessions.where(session_token: token).destroy_all
    session = Session.create_session_for_user!(self)
    session.session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    user if user&.is_password?(password)
  end
end
