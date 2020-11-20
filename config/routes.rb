Rails.application.routes.draw do
  devise_for :users, controllers: {
      registrations: 'users/registrations'
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_scope :user do
    root :to => 'devise/sessions#new'
  end

  get "/search", to: "pages#search", as: "search"

  resource :person_in_procedures, only: [:update]
  resources :notifications do
    member do
      patch :see
      put :see
    end
  end

  resources :procedures do
    resources :messages
  end

  namespace :admin do
      resources :crimes
      resources :local_prosecutions
  end


end
