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
class User < ApplicationRecord
  attr_reader :password

  validates :username, :password_digest, :session_token, presence: true
  validates :username, :session_token, uniqueness: true
  validates :password, length: { minimum: 7 }, allow_nil: true
  
  after_initialize :ensure_session_token

  #user.new => take in user params. passing in key value pairs. rails goes through each key value pairs and invoke
  #setter method for each params. rails will look for password =.., need password= method.
  #we get getters and setters for free if we have the columns in our migration.
  def password=(password)
    #ask about initialize methods under the hood
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  #need ensure token method, after_initialize.
  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    if user && user.is_password?(password)
      user
    else
      nil
    end
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def reset_session_token
    self.session_token = SecureRandom.urlsafe_base64
    self.save!
    self.session_token
  end
end
