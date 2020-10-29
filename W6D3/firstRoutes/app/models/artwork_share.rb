class ArtworkShare < ApplicationRecord
    validates :artwork_id, :viewer_id, presence: true
    validates :artwork_id, uniqueness: { 
        scope: :viewer_id, 
        message: 'single viewer per artwork' 
    }

    belongs_to :viewer, foreign_key: :viewer_id, class_name: 'User'
    belongs_to :artworks, foreign_key: :artwork_id, class_name: 'Artwork'
end