Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
  root to: "welcome#index"

  resource :welcome, only: :index

  resources :news

  resources :videos

  resources :league_tables do
    resources :seasons
    resources :fixtures
  end
end
