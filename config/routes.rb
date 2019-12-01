Rails.application.routes.draw do
  get 'photos/' => 'photos#index'
  post 'carts/update' => 'carts#update'
  post 'checkout' => 'checkout#loadCheckout'
  post 'payments/create' => 'payments#createPayment'
  post 'payments/processed' => 'payments#payments_processed'
  get 'tags' => 'tags#index'

  get 'sessions/new' => 'sessions#new'
  post 'sessions/login' => 'sessions#login'
  post 'refresh' => 'sessions#refresh'

  post 'users' => 'registrations#create'

  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)
end
