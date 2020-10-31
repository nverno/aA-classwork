class CatRentalRequestsController < ApplicationController
  def index
    render json: CatRentalRequest.all
  end

  def new
    @rental_request = CatRentalRequest.new
    @rental_request.cat_id = params[:cat_id]
    render :new
  end

  def create
    @rental_request = CatRentalRequest.new(request_params)
    if @rental_request.save
      redirect_to cat_url(current_cat)
    else
      flash.now[:errors] = @rental_request.errors.full_messages
      render :new
    end
  end

  def destroy; end

  def approve
    current_rental_request.approve!
    redirect_to cat_url(current_cat)
  end

  def deny
    current_rental_request.deny!
    redirect_to cat_url(current_cat)
  end

  private

  def current_rental_request
    @rental_request ||= CatRentalRequest.includes(:cat).find(params[:id])
  end

  def current_cat
    current_rental_request.cat
  end

  def request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end
end
