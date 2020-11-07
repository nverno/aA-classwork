# == Schema Information
#
# Table name: notes
#
#  id         :bigint           not null, primary key
#  user_id    :integer          not null
#  track_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  note       :text
#
class Note < ApplicationRecord
  validates :user_id, :track_id, presence: true
  belongs_to :user
  belongs_to :track
end
