Rails.application.routes.draw do
  get 'photos/' => 'photos#index'
  post 'carts/update' => 'carts#update'
  post 'checkout' => 'checkout#loadCheckout'
  post 'payments/create' => 'payments#createPayment'
  post 'payments/processed' => 'payments#payments_processed'
  get 'sessions/new' => 'session#new'

  devise_scope :user do
    post 'refresh/' => 'sessions#refresh'
    get 'users/' => 'sessions#show'
    post 'users/addresses' => 'sessions#addresses'
  end

  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :users, :controllers => {
    sessions: 'sessions',
    registrations: 'registrations'
  }

  ActiveAdmin.routes(self)
end
