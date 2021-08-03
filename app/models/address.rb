class Address < ApplicationRecord
  belongs_to :customer

  validates :postal_code, presence: true , format: { with: /\A[0-9]+\z/, message: "は半角数字のみで入力して下さい" }
  validates :address, presence: true
  validates :name, presence: true

  def address_select
    [postal_code, address, name].join(' ')
  end
end
