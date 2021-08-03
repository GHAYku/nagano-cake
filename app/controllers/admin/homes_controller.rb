class Admin::HomesController < ApplicationController
  def top
    case params[:order]
    when 'customer'
     #customer_id = Rails.application.routes.recognize_path(request.referer)[:id]
     @customer = Customer.find(params[:id])
     @orders = @customer.orders.page(params[:page]).per(10)
    when 'all'
     @orders = Order.page(params[:page]).per(10)
    #@total = order.order_details.inject(0) { |sum, amount| sum + amount }
    end
  end
end
