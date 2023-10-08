# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, path: 'auth'
  # devise_scope :users do
    # get '/signout', to: 'devise/sessions#destroy', as: :signout
  # end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root 'home#index'
end
