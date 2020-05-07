Rails.application.routes.draw do
  devise_for :customers, controllers: {
    sessions: 'public/sessions',
    passwords: 'public/passwords',
    registrations: 'public/registrations'
  }
  devise_for :admins, controllers: {
    sessions: 'admin/sessions',
    passwords: 'admin/passwords',
    registrations: 'admin/registrations'
  }
  scope module: :public do
    root to: 'homes#top'
    get '/customers/withdraw' => 'customers#withdraw'
    resources :customers, only: [:show, :edit, :update]
    put "/customers/:id/leave" => "customers#leave", as: 'customer_leave'
    resources :shipping_addresses, only: [:index, :create, :edit, :update, :destroy]
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :create, :update, :destroy]
    delete '/cart_items' => 'cart_items#destroy_all', as:'cart_item_destroy_all'
    resources :orders, only: [:index, :show, :new, :create]
    get '/orders/confirm' => 'orders#confirm'
    get '/orders/thanks' => 'orders#thanks'
  end

  namespace :admin do
    root to: 'homes#top'
    resources :customers, only: [:index, :show, :edit, :update]
    resources :items, only: [:index, :show, :new, :create, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :orders, only: [:index, :show, :update] do
      resources :order_items, only: [:update]
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
