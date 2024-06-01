# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users

  namespace :admin do
    resources :users, only: [:index] do
      member do
        get :show
        put :promote
      end
    end
    resources :transactions, only: [:index] do
      member do
        get :show
        put :approve
        put :deny
      end
    end
  end

  post 'auth/login', to: 'authentication#login'
  resources :transactions, only: %i[create index show update]
end
