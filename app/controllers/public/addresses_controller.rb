class Public::AddressesController < ApplicationController
  def index
    @addresses = current_customer.addressess.page(params[:page]).reverse_order
  end

  def edit
  end
end
