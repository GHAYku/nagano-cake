class Public::ItemsController < ApplicationController
  def index
   @items = Item.page(params[:page]).per(8)
    case params[:order]
    when 'seatch'
     @genres = Genre.find(params[:id])
     @items = @genres.item.page(params[:page]).per(8)
    end
  end

  def show
   @item = Item.find(params[:id])
   @cart_item = CartItem.new
  end
end
