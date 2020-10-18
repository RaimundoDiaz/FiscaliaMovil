Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'procedures#index'

  resources :users do
    resources :procedures
  end

  resources :procedures

end
