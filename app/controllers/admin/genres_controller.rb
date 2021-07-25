class Admin::GenresController < ApplicationController

  def index
    @genres = Genre.page(params[:page]).reverse_order
    @genre = Genre.new
  end

  def create
    genre = Genre.new(genre_params)
    genre.save
    if genre.save
      flash[:notice]="ジャンルを作成しました."
      redirect_to admin_genres_path
    else
      @genres = Genre.page(params[:page]).reverse_order
      @genre = Genre.new
      render :index
    end

  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    genre = Genre.find(params[:id])
    if genre.update(genre_params)
      flash[:notice]="ジャンルを変更しました."
      redirect_to admin_genres_path
    else
      @genre = Genre.find(params[:id])
      render :edit
    end
  end

  private
  def genre_params
    params.require(:genre).permit(:name)
  end

end
