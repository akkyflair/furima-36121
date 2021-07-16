class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if  @item.save
        redirect_to root_path
    else
        render :new
    end      
  end

  private
  def item_params
    params.require(:item).permit(:title, :text, :price, :category_id, :status_id, :delivery_fee_id, :prefecture_id, :delivery_date_id, :image, ).merge(user_id: current_user.id)
  end

end