class Public::HomesController < ApplicationController
  def top
    @items = Item.all
    @genres = Genre.page(params[:page]).per(5)
  end

  def about
  end
end
