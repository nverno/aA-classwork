class UsersController < ApplicationController
  def index
    render json: User.all
  end

  def create
    user = User.new(user_params)
    if user.save!
      render json: user
    else
      render json: user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    render json: User.find_by(id: params[:id])
  end

  def update
    user = User.find_by(id: params[:id])
    if User.update(params[:id], user_params)
      render json: user
    else
      render json: user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    user = User.find_by(id: params[:id])
    user.destroy
  end

  private

  def user_params
    params.require(:user).permit(:username)
  end
end
