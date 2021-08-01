class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items
    @total = @cart_items.inject(0) { |sum, item| sum + sum_of_price }
  end

  def create
   cart_item = CartItem.new(cart_item_params)
   #cart_item.customer_id = CartItem.find_by(customer_id: params[:cart_item][:customer_id])
   #cart_item.item_id = CartItem.find_by(item_id: params[:cart_item][:item_id])
   cart_item.save
   flash[:notice]="商品をカートに入れました"
   redirect_to cart_items_path
  end

  def update
   cart_item=CartItem.find(params[:id])
	 cart_item.update(cart_item_params)
	 flash[:notice] = "数量変更しました"
	 redirect_back(fallback_location: root_path)
  end

  def destroy_all
   current_customer.cart_items.destroy_all
	 redirect_to items_path
  end

  def destroy
   cart_item = CartItem.find(params[:id])
	 cart_item.destroy
	 flash[:notice] = "カートから商品を削除しました"
	 redirect_back(fallback_location: root_path)
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:amount,:item_id,:customer_id)
  end
end
