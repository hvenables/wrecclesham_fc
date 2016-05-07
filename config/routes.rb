Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
  root to: "welcome#index"

  resource :welocome, only: :index

  resources :news

  resources :league_tables do
    resources :teams
    resources :fixtures
  end
end
