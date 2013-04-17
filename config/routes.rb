RssReading::Application.routes.draw do
  devise_for :users, controllers: { :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  resources :users do
    resources :channels do
      resources :articles, only: [:index]
    end

    resources :favorites, only: [:index]
  end

  match 'users/:user_id/favorite/:article_id' => 'favorites#create', as: :create_favorite, via: :post
  match 'users/:user_id/favorite/:article_id' => 'favorites#destroy', as: :destroy_favorite, via: :delete
end
