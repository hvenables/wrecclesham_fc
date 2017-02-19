Rails.application.routes.draw do
  devise_for :users

  root to: "welcome#index"

  resource :welcome, only: :index

  resources :news

  resources :videos

  resources :cups, except: :show do
    resource :fixtures, only: :show
  end

  resources :team, only: [] do
    resource :fixtures, only: [:show, :create, :update]
  end

  resources :league_tables do
    resources :seasons
    resource :fixtures, only: :show
  end

  resources :about, only: [:index, :edit, :update]
end
