class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @addresses = current_customer.addresses
  end

  def confirm
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @cart_items = current_customer.cart_items
    @total = @cart_items.inject(0) { |sum, item| sum + item.sub_total }

    if params[:select_address] == "1"
      @order.address = current_customer.addresses
      @order.postal_code = current_customer.post_code
      @order.address = current_customer.addresses
     elsif params[:select_address] == "2"
      @address = current_customer.addresses.find(params[:address_id])
      @order.address = @address.address
      @order.postal_code = @address.postal_code
      @order.address = @address.address
     elsif params[:select_address] == "3"
    end
  end

  def thanks

  end

  def index
  end

  def show
  end

  def create
   @order = current_user.orders.new(order_params)
   @order.save
   @cart_items = current_user.cart_items.all
     @cart_items.each do |cart_item|
      @order_items = @order.order_items.new
      @order_items.item_id = cart_item.item.id
      @order_items.name = cart_item.item.name
      @order_items.price = cart_item.item.taxin_price
      @order_items.amount = cart_item.amount
      @order_items.save
      end
　　　current_user.cart_items.destroy_all
  end

  private

  def order_params
	 params.permit(:customer_id, :payment_method, :total_payment, :postal_code, :address, :name)
  end
end
