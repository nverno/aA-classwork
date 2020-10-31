# == Schema Information
#
# Table name: collections
#
#  id         :bigint           not null, primary key
#  user_id    :integer          not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Collection < ApplicationRecord
  validates :user_id, :name, presence: true

  belongs_to :user
  has_many :artwork_collections, dependent: :destroy

  has_many :artworks,
           through: :artwork_collections,
           source: :artwork
end
