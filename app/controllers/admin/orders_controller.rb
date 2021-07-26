class Admin::OrdersController < ApplicationController
  def show
    @order_details = @order.order_detail
    @order = Order.find(params[:id])
  end
  
  def update
    @order = Order.find(params[:id])
    @Order.update(order_params)
    flash[:notice] = "注文ステータスを変更しました"
    redirect_to admin_order_path
  end
  
  private
  def order_params
    params.require(:order).permit(:status)
  end
  
end
