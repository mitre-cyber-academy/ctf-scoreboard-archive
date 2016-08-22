# frozen_string_literal: true
Scoreboard::Application.routes.draw do
  # admin
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  # devise
  devise_for :users, controllers: { sessions: :sessions }
  devise_scope :user do
    get 'signin', to: 'devise/sessions#new'
    get 'signout', to: 'devise/sessions#destroy'
  end

  # game
  resources :challenges, only: [:index, :show] do
    member do
      post 'submit_flag'
    end
  end
  resources :achievements, only: [:index]
  resources :messages, only: [:index]
  resources :users, only: [:index, :show], as: :players do
    resources :keys, except: [:index, :show]
    member do
      get 'download'
    end
  end
  get 'summary' => 'games#summary'

  # root
  root to: 'games#show'
end
