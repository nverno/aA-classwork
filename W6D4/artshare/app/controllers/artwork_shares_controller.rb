class ArtworkSharesController < ApplicationController
  def index
    render json: ArtworkShare.all
  end

  def create
    artworkshare = ArtworkShare.new(artworkshare_params)
    if artworkshare.save!
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

  private

  def artworkshare_params
    params.require(:artworkshare).permit(:artwork_id, :viewer_id)
  end
end
