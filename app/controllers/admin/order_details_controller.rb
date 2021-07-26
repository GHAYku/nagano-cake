class Admin::OrderDetailsController < ApplicationController
  
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(order_detail_params)
    flash[:notice] = "製作ステータスを変更しました"
    #どれか一つ製作ステータスが「製作中」になると注文ステータスが「製作中」に自動更新更新
    #全部の製作ステータスが「製作完了」になると注文ステータスが「発送待ち」に自動更新
    redirect_to admin_order_path
  end

  private
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
