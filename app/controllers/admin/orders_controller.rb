class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @total = @order.total_payment.to_s + @order.shipping_cost.to_s
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    flash[:notice] = "注文ステータスを変更しました"
    redirect_to admin_order_path
  end

  private
  def order_params
    params.require(:order).permit(:status)
  end
end
