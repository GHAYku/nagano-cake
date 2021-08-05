class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  def new
    @order = Order.new
    @addresses = current_customer.addresses
  end

  def confirm
    @order = Order.new(order_params)
    @order.payment_method = params[:order][:payment_method].to_i
    #@order.customer_id = current_customer.id
    @cart_items = current_customer.cart_items
    @order.shipping_cost = 800
    @total = @cart_items.inject(0) { |sum, item| sum + item.sub_total }
    @totals = @total + @order.shipping_cost
    if params[:select_address] == "1"
      @order.name = current_customer.last_name + current_customer.first_name
      @order.postal_code = current_customer.post_code
      @order.address = current_customer.address
    elsif params[:select_address] == "2" && params[:order][:select_address].present?
      @address =  Address.find(params[:order][:select_address])
      @order.name = @address.name
      @order.postal_code = @address.postal_code
      @order.address = @address.address
    elsif params == "3"
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
  end

  def create
   @order = Order.new(order_params)
   @order.payment_method = params[:order][:payment_method].to_i
   @order.shipping_cost = 800
   @cart_items = current_customer.cart_items.all
   @total = @cart_items.inject(0) { |sum, item| sum + item.sub_total }
   @totals = @total + @order.shipping_cost
   @order.status = 0
   if @order.save
     @cart_items.each do |cart_item|
      @order_details = OrderDetail.new
			@order_details.order_id = @order.id
			@order_details.item_id = cart_item.item_id
      @order_details.price = cart_item.item.taxin_price
      @order_details.amount = cart_item.amount
      @order_details.making_status = 0
      @order_details.save
     end
     current_customer.cart_items.destroy_all
     redirect_to orders_thanks_path
   else
      @addresses = current_customer.addresses
     render :new
   end
  end

  private

  def order_params
	 params.require(:order).permit(:customer_id, :total_payment, :postal_code, :address, :name)
  end
end
