class Order < ApplicationRecord
  has_many :order_details, dependent: :destroy
  belongs_to :customer

  validates :customer_id, presence: true
	validates :postal_code, presence: true
	validates :address, presence: true
	validates :name, presence: true
	validates :payment_method, presence: true

  enum payment_method: {クレジットカード: 0, 銀行振込: 1}
  enum status:  {入金待ち: 0,入金確認: 1,製作中: 2,発送待ち: 3,発送済: 4}

  after_update do
  if self.status == "入金確認"
   self.order_details.each {|order_details|
   order_details.update(making_status: "製作待ち")
   }
  end
 end
end
