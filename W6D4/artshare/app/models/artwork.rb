# == Schema Information
#
# Table name: artworks
#
#  id        :bigint           not null, primary key
#  title     :string           not null
#  image_url :string           not null
#  artist_id :integer          not null
#
class Artwork < ApplicationRecord
  validates :title, :artist_id, :image_url, presence: true
  validates :title,
            uniqueness: {
              scope: :artist_id,
              message: 'title already used'
            }

  belongs_to :artist,
             foreign_key: :artist_id,
             class_name: 'User'

  has_many :artwork_shares,
           foreign_key: :artwork_id,
           class_name: 'ArtworkShare'

  has_many :shared_viewers,
           through: :artwork_shares,
           source: :viewer

  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable
  has_many :likers,
           through: :likes,
           source: :user
end
