# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  user_id    :integer          not null
#  artwork_id :integer          not null
#  body       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Comment < ApplicationRecord
  validates :user_id, :artwork_id, :body, presence: true

  belongs_to :user
  belongs_to :artwork
  has_many :likes, as: :likeable
  has_many :likers,
           through: :likes,
           source: :user
end
