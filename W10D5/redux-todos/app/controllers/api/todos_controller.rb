class Api::TodosController < ApplicationController
  def show
    render json: Todo.find(params[:id]), include: :tags
  end

  def index
    # @todos = Todo.all
    @todos = current_user.todos
    render json: @todos, include: :tags
  end

  def create
    # @todo = Todo.new(todo_params)
    @todo = current_user.todos.new(todo_params)
    if @todo.save
      render json: @todo, include: :tags
    else
      render json: @todo.errors.full_messages, status: 422
    end
  end

  def update
    # @todo = Todo.find(params[:id])
    @todo = current_user.todos.find(params[:id])
    if @todo.update(todo_params)
      render json: @todo, include: :tags
    else
      render json: @todo.errors.full_messages, status: 422
    end
  end

  def destroy
    # @todo = Todo.find(params[:id])
    @todo = current_user.todos.find(params[:id])
    @todo.destroy
    render json: @todo, include: :tags
  end

  private

  def todo_params
    params.require(:todo).permit(:title, :body, :done, tag_names: [])
  end
end
