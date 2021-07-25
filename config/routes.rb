Rails.application.routes.draw do

 devise_for :admins
 #adminモデルにて不要なルーティングが実行できないように処理を記載してます。
 
 devise_for :customers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :admin do
    resources :genres, only:[:index, :update, :create, :edit]
    resources :items, only: [:new, :create, :index, :show, :edit, :update]
  end

end
