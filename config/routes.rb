Rails.application.routes.draw do
  resources :productions, only: [:index]
  resources :permits, only: [:index]
  root to: 'permits#index', via: :get
end
