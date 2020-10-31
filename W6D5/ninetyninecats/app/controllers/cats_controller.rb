class CatsController < ApplicationController
  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find_by(id: params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cats_params)
    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end

  def edit
    @cat = Cat.find_by(id: params[:id])

    if @cat.nil?
      render json: "#{params[:id]} not found"
    else
      render :edit
    end
  end

  def update
    @cat = Cat.find_by(id: params[:id])

    if @cat.update(cats_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_message
      render :edit
    end
  end

  private

  def cats_params
    params.require(:cat).permit(:name, :birth_date, :color, :description, :sex, :age)
  end
end
