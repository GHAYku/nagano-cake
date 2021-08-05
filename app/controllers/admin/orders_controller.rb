class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @total =  @order_details.inject(0) { |sum, item| sum + item.sub_total }
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
