Rails.application.routes.draw do
  get 'photos/' => 'photos#index'

  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :users, :controllers => {
    sessions: 'sessions',
    registrations: 'registrations'
  }

  ActiveAdmin.routes(self)
end
