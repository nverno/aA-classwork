class LikesController < ApplicationController
  def index
    render json: Like.all
  end
end
