class Public::HomesController < ApplicationController
  def top
    @items = Item.all
    @genres = Genre.page(params[:page]).per(5).reverse_order
  end

  def about
  end
end
