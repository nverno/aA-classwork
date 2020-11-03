# == Schema Information
#
# Table name: sessions
#
#  id              :bigint           not null, primary key
#  user_id         :integer          not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  http_user_agent :string
#  http_host       :string
#
class Session < ApplicationRecord
  validates :user_id, :session_token, presence: true
  validates :session_token, uniqueness: true
  after_initialize :ensure_session_token

  belongs_to :user

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end

  def self.create_session_for_user!(user, env)
    session = Session.new(
      user_id: user.id,
      http_host: env['HTTP_HOST'],
      http_user_agent: env['HTTP_USER_AGENT']
    )
    session.save!
    session
  end

  # Log user out of all sessions
  def self.destroy_all(user)
    Session.find_by(user_id: user.id).destroy_all
  end
end
