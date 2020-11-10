class SubsController < ApplicationController
  before_action :require_logged_in, only: %i[upvote downvote]
  before_action :require_moderator, only: %i[edit update destroy]
  helper_method :moderator?

  def require_moderator
    @sub = Sub.find(params[:id])
    redirect_to sub_url(params[:id]) unless current_user&.id == @sub.moderator_id
  end

  def moderator?
    current_user&.id == @sub.moderator_id
  end

  def upvote
    @sub = Sub.find(params[:id])
    vote = @sub.votes.find_or_initialize_by(user: current_user)
    vote.update(value: 1)
    redirect_to subs_url
  end

  def downvote
    @sub = Sub.find(params[:id])
    vote = @sub.votes.find_or_initialize_by(user: current_user)
    vote.update(value: -1)
    redirect_to subs_url
  end

  def index
    @subs = Sub.all
    render :index
  end

  def show
    @sub = Sub.find_by(id: params[:id])
    if @sub
      render :show
    else
      flash.now[:errors] = ['This sub does not exist']
      redirect_to subs_url
    end
  end

  def new
    @sub = Sub.new
    render :new
  end

  # POST /subs
  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def destroy
    @sub = Sub.find_by(id: params[:id])
    redirect_to subs_url if @sub&.destroy
  end

  def edit
    @sub = Sub.find_by(id: params[:id])
    render :edit
  end

  def update
    @sub = Sub.find_by(id: params[:id])
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
