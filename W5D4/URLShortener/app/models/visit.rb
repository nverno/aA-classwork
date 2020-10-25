# == Schema Information
#
# Table name: visits
#
#  id               :bigint           not null, primary key
#  shortened_url_id :integer          not null
#  user_id          :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Visit < ApplicationRecord
  validates :shortened_url_id, :user_id, presence: true

  belongs_to :shortened_url
  belongs_to :user

  def self.record_visit!(user, shortened_url)
    Visit.create!(
      user_id: user.id,
      shortened_url_id: shortened_url.id
    )
  end
end
