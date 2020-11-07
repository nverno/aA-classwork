class AlbumsController < ApplicationController
  before_action :require_logged_in, except: %i[index show]

  def index
    @albums = Album.all
    render :index
  end

  def new
    @album = Album.new
    @album.band_id = params[:band_id]
    render :new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to albums_url
    else
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @album&.destroy
  end

  def edit
    @album = Album.find(params[:id])
    render :edit
  end

  def update
    @album = Album.find(params[:id])
    if @album.update(album_params)
      redirect_to album_url(@album)
    else
      flash[:errors] = @album.errors.full_messages
      redirect_to :edit
    end
  end

  def show
    @album = Album.find(params[:id])
    render :show
  end

  private

  def album_params
    params.require(:album).permit(:title, :year, :live, :band_id)
  end
end
