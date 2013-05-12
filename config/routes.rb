RssReading::Application.routes.draw do
  devise_for :users, controllers: { :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  resources :users do
    resources :channels do
      resources :articles, only: [:index]
    end

    resources :articles, only: [] do
      resources :comments, only: [:new, :create]
    end

    resources :favorites, only: [:index]
  end

  get :search, to: "search#index"

  match 'users/:user_id/favorite/:article_id' => 'favorites#create', as: :create_favorite, via: :post
  match 'users/:user_id/favorite/:article_id' => 'favorites#destroy', as: :destroy_favorite, via: :delete

  unless Rails.application.config.consider_all_requests_local
    match '*not_found', to: 'application#error_404'
  end
end
