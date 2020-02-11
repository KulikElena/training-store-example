Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
                                    sessions: 'users/sessions' }
  ActiveAdmin.routes(self)

  root 'books#index'

  resources :order_items, only: %i[create update destroy]
  resources :books, only: %i[show index]
  resources :reviews, only: :create
  resources :orders, only: %i[index show]
  resource :cart, only: :show

  get 'settings' => 'users#edit'
  patch 'settings' => 'users#update'
  patch 'coupons' => 'coupons#update'
  patch 'order_items' => 'order_items#update'
end
