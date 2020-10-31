class CollectionsController < ApplicationController
  def index
    colls = if params[:user_id]
              Collection.where(user_id: params[:user_id])
            else
              Collection.all
            end
    render json: colls
  end

  def show
    render json: Collection.find_by(id: params[:id]).artworks
  end

  def destroy
    coll = Collection.find_by(id: params[:id])
    coll.destroy
    render json: coll
  end

  def create
    coll = Collection.new(user_id: params[:user_id], name: params[:name])
    if coll.save
      render json: coll
    else
      render json: coll.errors.full_messages, status: :unprocessable_entity
    end
  end

  # Add artwork to collection
  # POST /collections/:collection_id/artworks/:artwork_id/add
  def add
    coll = Collection.find_by(id: params[:collection_id])
    work = Artwork.find_by(id: params[:artwork_id])
    ac = ArtworkCollection.new(collection_id: coll.id, artwork_id: work.id)
    if ac.save
      render json: ac
    else
      render json: ac.errors.full_messages, status: :unprocessable_entity
    end
  end

  # Remove artwork from collection
  # DELETE /collections/:collection_id/artworks/:artwork_id/remove
  def remove
    coll = Collection.find_by(id: params[:collection_id])
    work = Artwork.find_by(id: params[:artwork_id])
    ac = ArtworkCollection.find_by(collection_id: coll.id, artwork_id: work.id)
    ac && ac.destroy
    render json: ac
  end
end
