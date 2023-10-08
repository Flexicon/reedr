# frozen_string_literal: true

# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  devise_for :users, path: 'auth'

  root 'home#index'

  resources :feeds
end
