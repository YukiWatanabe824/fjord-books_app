Rails.application.routes.draw do
  concern :commentable do
    resources :comments, only: [:show, :edit, :create, :update, :destroy]
  end
  resources :reports, concerns: :commentable 
  resources :books, concerns: :commentable

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users
  root to: 'books#index'
  resources :users, only: %i[index show] do
    resource :relationships, only: %i[create destroy]
    scope module: :users do
      resources :followings, only: [:index]
      resources :followers, only: [:index]
    end
  end
end
