class CommentsController < ApplicationController
  # Retrieve comment for an artwork or user
  # user_id, artwork_id
  def index
    comments = if params[:user_id]
                 Comment.where(user_id: params[:user_id])
               elsif params[:artwork_id]
                 Comment.where(artwork_id: params[:artwork_id])
               else
                 Comment.all
               end
    render json: comments
  end

  def create
    comment = Comment.new(comment_params)
    if comment.save
      render json: comment, status: :created
    else
      render json: comment.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    render json: comment
  end

  # POST /comments/:id/like
  def like
    like = Like.new(user_id: params[:user_id], likeable_id: params[:id], likeable_type: 'Comment')
    if like.save
      render json: like
    else
      render json: like.errors.full_messages, status: :unprocessable_entity
    end
  end

  # POST /comments/:id/unlike
  def unlike
    like = Like.find_by(user_id: params[:user_id], likeable_id: params[:id], likeable_type: 'Comment')
    if like.destroy
      render json: like
    else
      render json: like.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :artwork_id, :body)
  end
end
