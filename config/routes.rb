Rails.application.routes.draw do




  scope module: :public do
    root 'homes#top'
    get 'homes/about'
  end
  
  
 devise_for :admins, path: 'admin',:controllers => {
    :sessions => 'admin/sessions'
  }
 #adminモデルにて不要なルーティングが実行できないように処理を記載してます。

 devise_for :customers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :admin do
    resources :genres, only:[:index, :update, :create, :edit]
    resources :items, only: [:new, :create, :index, :show, :edit, :update]
    resources :items, only: [:new, :create, :index, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    get 'homes/top'
    resources :orders, only: [:show,:update]
    resources :order_details, only: [:update]
  end

end
