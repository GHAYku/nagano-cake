class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  def top
    case params[:order]
    when 'customer'
     #customer_id = Rails.application.routes.recognize_path(request.referer)[:id]
     @customer = Customer.find(params[:id])
     @orders = @customer.orders.page(params[:page]).per(10).reverse_order
    when
     @orders = Order.page(params[:page]).per(10).reverse_order
    #@total = order.order_details.inject(0) { |sum, amount| sum + amount }
    end
  end
end
