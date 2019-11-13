Rails.application.routes.draw do
  get 'photos/' => 'photos#index'
  get 'photos/show'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/signin' => 'signin#login'
end
