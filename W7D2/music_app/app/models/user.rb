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
class User < ApplicationRecord
  attr_reader :password

  validates :email, :password_digest, presence: true
  validates :password, length: { minimum: 6 }, allow_nil: true

  after_initialize :ensure_session_token

  has_many :notes, dependent: :destroy

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    user if user&.is_password?(password)
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    save!
    session_token
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end
end
