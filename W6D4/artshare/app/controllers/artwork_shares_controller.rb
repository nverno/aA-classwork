class ArtworkSharesController < ApplicationController
  def index
    render json: ArtworkShare.all
  end

  def create
    artworkshare = ArtworkShare.new(artworkshare_params)
    if artworkshare.save
      render json: artwork
    else
      render json: artworkshare.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    render json: ArtworkShare.find_by(id: params[:id])
  end

  def update
    artworkshare = ArtworkShare.find_by(id: params[:id])
    if ArtworkShare.update(params[:id], artworkshare_params)
      render json: artwork
    else
      render json: artworkshare.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    artworkshare = ArtworkShare.find_by(id: params[:id])
    artworkshare.destroy
  end

  # Show all artwork/artwork_share favorites
  # XXX: probably should be defined elsewhere?
  # /favorites
  def favorites
    artworks = Artwork.where(favorite: true)
    shares = ArtworkShare.where(favorite: true)
    render json: artworks + shares
  end

  def favorite
    work = ArtworkShare.find_by(id: params[:id], viewer_id: params[:viewer_id])
    work.favorite = true
    work.save
    render json: work
  end

  def unfavorite
    work = ArtworkShare.find_by(id: params[:id], viewer_id: params[:viewer_id])
    work.favorite = false
    work.save
    render json: work
  end

  private

  def artworkshare_params
    params.require(:artworkshare).permit(:artwork_id, :viewer_id)
  end
end
