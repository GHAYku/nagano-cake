class Item < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  belongs_to :genre
  attachment :image

  validates :name, presence: true
  validates :image, presence: true
  validates :introduction, presence: true
  validates :genre_id, presence: true
  validates :price, presence: true
  validates :is_active, inclusion: { in: [true, false] }

  def taxin_price
   price * 1.1
  end

  def self.search_for(content)
   Item.where('name LIKE ?', '%'+content+'%')
  end
end
