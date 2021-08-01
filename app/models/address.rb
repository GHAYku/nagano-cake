class Address < ApplicationRecord
  belongs_to :customer

  def address_select
    [postal_code, address, name].join(' ')
  end
end
