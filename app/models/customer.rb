class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい' }
  validates :first_name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい' }
  validates :email, presence: true
  validates :postal_code, presence: true, format: { with: /\A[0-9]+\z/, message: "は半角数字のみで入力して下さい" }
  validates :address, presence: true
  validates :phone_number, presence: true, format: { with: /\A[0-9]+\z/, message: "は半角数字のみで入力して下さい" }

end
