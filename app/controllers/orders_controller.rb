class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create,]
  before_action :set_item, only: [:index, :create]
  before_action :contributor_confirmation, only: [:index, :create]
  before_action :sold_out_item, only: [:index, :create]

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      @order_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private
  def order_params
    params.require(:order_address).permit(:postcode,:prefecture_id, :city, :block, :building, :phone).merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def contributor_confirmation
    if current_user == @item.user
      redirect_to root_path 
    end
  end

   def sold_out_item
    redirect_to root_path if @item.order.present?
   end

end
