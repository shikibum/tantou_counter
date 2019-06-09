# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tantous
  resources :users, only: %i[show] do
    resources :campaigns, only: %i[show index]
  end
  root to: 'tantous#index'
end
