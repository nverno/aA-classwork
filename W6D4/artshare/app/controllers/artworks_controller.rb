class ArtworksController < ApplicationController
  # 1. https://localhost/users?id=kdkd
  # 2. /users/:user_id/artworks => {user_id: ... }
  def index
    if params[:user_id]
      # params = { user_id => 1 }
      # SELECT * FROM artworks WHERE artists.id = user_id
      user = User.find_by(id: params[:user_id])
      render json: user.artworks + user.shared_artworks
    # render json: Artwork.find_by(artist_id: params[:user_id])
    else
      render json: Artwork.all
    end
  end

  def create
    artwork = Artwork.new(artwork_params)
    if artwork.save!
      render json: artwork
    else
      render json: artwork.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    render json: Artwork.find_by(id: params[:id])
  end

  def update
    artwork = Artwork.find_by(id: params[:id])
    if Artwork.update(params[:id], artwork_params)
      render json: artwork
    else
      render json: artwork.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    artwork = Artwork.find_by(id: params[:id])
    artwork.destroy
  end

  # /artworks/:id/like, params = {user_id: ...}
  def like
    like = Like.new(user_id: params[:user_id], likeable_id: params[:id], likeable_type: 'Artwork')
    if like.save
      render json: like
    else
      render json: like.errors.full_messages, status: :unprocessable_entity
    end
  end

  def unlike
    like = Like.find_by(user_id: params[:user_id], likeable_id: params[:id], likeable_type: 'Artwork')
    if like.nil?
      render html: "There is no like ##{params[:id]} dumbass"
    elsif like.destroy
      render json: like
    else
      render json: like.errors.full_messages, status: :unprocessable_entity
    end
  end

  # /artworks/:id/favorite
  def favorite
    work = Artwork.find_by(id: params[:id])
    if work
      work.favorite = true
      work.save
      render json: work
    else
      render html: "Artwork #{params[:id]} doesn't exist.."
    end
  end

  def unfavorite
    work = Artwork.find_by(id: params[:id])
    if work
      work.favorite = false
      work.save
      render json: work
    else
      render html: "Artwork #{params[:id]} doesn't exist.."
    end
  end

  private

  def artwork_params
    params.require(:artwork).permit(:title, :image_url, :artist_id)
  end
end
