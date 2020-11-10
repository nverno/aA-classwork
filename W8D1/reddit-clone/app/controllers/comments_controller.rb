class CommentsController < ApplicationController
  before_action :require_logged_in

  def new
    @comment = Comment.new(post_id: params[:post_id])
    render :new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    if @comment.save
      redirect_to post_url(@comment.post_id)
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  def vote(dir)
    @comment = Comment.find(params[:id])
    vote = @comment.votes.find_or_initialize_by(user: current_user)
    flash[:errors] = vote.errors.full_messages unless vote.update(value: dir)
    redirect_to post_url(@comment.post_id)
  end

  def upvote
    vote(1)
  end

  def downvote
    vote(-1)
  end

  private

  def comment_params
    params.require(:comment).permit(:post_id, :parent_comment_id, :content)
  end
end
