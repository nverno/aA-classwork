class CatsController < ApplicationController
  before_action :redirect_unless_owner, only: [:edit, :update]

  # Only cat owner can modify their cat
  def redirect_unless_owner
    unless current_user && current_user.cats.find_by(id: params[:id])
      flash[:errors] = ['Must be owner to modify cat']
      redirect_to cats_url
    end
  end

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    if logged_in?
      @cat = Cat.new
      render :new
    else
      flash[:errors] = ['Must be logged in to create cat']
      redirect_to cats_url
    end
  end

  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id
    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update_attributes(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :edit
    end
  end

  private

  def cat_params
    params.require(:cat).permit(:age, :birth_date, :color, :description, :name, :sex, :user_id)
  end
end
