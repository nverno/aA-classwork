# == Schema Information
#
# Table name: artwork_collections
#
#  id            :bigint           not null, primary key
#  collection_id :integer          not null
#  artwork_id    :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class ArtworkCollection < ApplicationRecord
  validates :collection_id, :artwork_id, presence: true

  belongs_to :collection
  belongs_to :artwork

  has_one :creator,
          through: :collection,
          source: :user
end
