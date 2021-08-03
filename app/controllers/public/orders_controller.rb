class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @addresses = current_customer.addresses
  end

  def confirm
    @order = Order.new(order_params)
    @order.payment_method = params[:order][:payment_method].to_i
    @order.customer_id = current_customer.id
    @cart_items = current_customer.cart_items
    @total = @cart_items.inject(0) { |sum, item| sum + item.sub_total }

    @totals = @cart_items.inject(0) { |sum, item| sum + item.sub_total } + 800
    #↑送料を含めた請求額

    if params[:select_address] == "1"
      @order.name = current_customer.last_name + current_customer.first_name
      @order.postal_code = current_customer.post_code
      @order.address = current_customer.address
    elsif params[:select_address] == "2"
      @address =  Address.find(params[:order][:select_address])
      @order.name = @address.name
      @order.postal_code = @address.postal_code
      @order.address = @address.address
    elsif params[:select_address] == "3"
    end
  end

  def thanks
  end

  def index
   @orders = current_customer.orders
  end

  def show
   @order = Order.find(params[:id])
	 @order_details = @order.order_details
	 @total =  @order_details.inject(0) { |sum, item| sum + item.sub_total }
	 #↑商品合計
  end

  def create
   @order = current_customer.orders.new(order_params)
   @order.save
   @cart_items = current_customer.cart_items.all
     @cart_items.each do |cart_item|
      @order_details = OrderDetail.new
			@order_details.order_id = @order.id
			@order_details.item_id = cart_item.item_id
      @order_details.price = cart_item.item.taxin_price
      @order_details.amount = cart_item.amount
      @order_details.save
  end
  current_customer.cart_items.destroy_all
  redirect_to orders_thanks_path
  end

  private

  def order_params
	 params.require(:order).permit(:customer_id, :total_payment, :postal_code, :address, :name)
  end
end
