Rails.application.routes.draw do

  scope module: :public do
    root 'homes#top'
    get 'homes/about'
    resource :customers,only: [:edit,:update,:show] do
     collection do
      get 'secession'
      patch 'withdrawal'
      end
    end
    resources :addresses,only: [:edit,:update,:index,:create,:destroy]
    resources :items,only: [:show,:index]
    delete "cart_items/destroy_all"
    get 'orders/thanks'
    resources :cart_items,only: [:create,:index,:destroy,:update]
    resources :orders,only: [:new, :index, :show, :create]
    post 'orders/confirm'
    get '/search', to: 'searches#search'
  end
 devise_for :customers, :controllers => {
  :registrations => 'public/customers/registrations',
  :sessions => 'public/customers/sessions'
 }

 devise_for :admins, path: 'admin',:controllers => {
    :sessions => 'admin/sessions'
  }
 #adminモデルにて不要なルーティングが実行できないように処理を記載してます。
  namespace :admin do
    get 'homes/top'
    resources :genres, only:[:index, :update, :create, :edit]
    resources :items, only: [:new, :create, :index, :show, :edit, :update]
    resources :items, only: [:new, :create, :index, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    get 'admin' => 'homes#top', as: 'home'
    resources :orders, only: [:show,:update]
    resources :order_details, only: [:update]
    get '/search', to: 'searches#search'
  end

end
