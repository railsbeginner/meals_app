  class Api::OrdersController < ApplicationController

  before_filter :set_current_user, :authenticate_user!, except: [:index, :show]
  
  def create
  	@order = Order.new
  	if @order.save
  		render json: @order
  	else
  		render json: @order.errors, status: :unprocessable_entity
  	end
  end

  def index
  	@orders = Order.all.order('created_at DESC')
  	render json: @orders

  end

  def show
    @order = Order.find(params[:id])
    render json: @order
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    render json: @order
  end

  private
  def order_params
  	params.require(:order).permit(:id, :finalized, :ordered, :delivered)
  end
end
