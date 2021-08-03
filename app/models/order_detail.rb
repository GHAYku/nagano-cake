class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

  def sub_total
   item.taxin_price * amount
  end

  enum making_status:  {製作不可: 0,製作待ち: 1,製作中: 2,製作完了: 3}

  after_update do
   order_details = self.order.order_details
    if order_details.any? {|order_details| order_details.making_status == "製作中"} == true
      self.order.update(status: "製作中")
    elsif order_details.all? {|order_details| order_details.making_status == "製作完了"} == true
      self.order.update(status: "発送準備中") # 注文ステータスを発送準備中に変更する
    end
  end
end
