class PostsController < ApplicationController
  def index; end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  def new
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def post_params
    # debugger
    params[:post][:sub_ids]&.each do |_k, id|
      PostSub.create(sub_id: id, post_id: params[:id])
    end
    params.require(:post).permit(:title, :url, :content, :author_id, :sub_id, sub_ids: [])
  end

  def vote(dir)
    @post = Post.find(params[:id])
    vote = @post.votes.find_or_initialize_by(user: current_user)
    flash[:errors] = vote.errors.full_messages unless vote.update(value: dir)
    redirect_to sub_url(@post.sub_id)
  end

  def upvote
    vote(1)
  end

  def downvote
    vote(-1)
  end
end
