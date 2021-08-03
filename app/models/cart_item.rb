class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :customer

  validates :amount, presence: true
  validates :customer_id, presence: true
  validates :item_id, presence: true

  def sub_total
   item.taxin_price * amount
  end
end
