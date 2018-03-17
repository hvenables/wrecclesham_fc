# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  root to: 'welcome#index'

  resource :welcome, only: :index

  resources :news

  resources :videos

  scope module: :competition do
    resources :cups, except: :show
  end

  resources :cups, only: [] do
    resource :fixtures, only: :show
  end

  resources :team, only: [] do
    resource :fixtures, only: %i[show create update]
  end

  scope module: :competition do
    resources :league_tables
  end

  resources :league_tables, only: [] do
    resource :seasons
    resource :fixtures, only: :show
  end

  resources :about, only: %i[index edit update]

  namespace :charts do
    resource :recent_form, only: :show, controller: :recent_form
  end
end
