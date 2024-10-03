Rails.application.routes.draw do
  get 'auth/github/callback', to: 'user_sessions#create'
  get 'auth/failure', to: 'user_sessions#failure'
  delete 'logout', to: 'user_sessions#destroy'
  resource :current_user, only: %i[update destroy] do
    scope module: :current_users do
      resources :issues, only: %i[index]
      resources :wikis, only: %i[index]
      resources :contributions, only: %i[index]
    end
  end
  resources :users, param: :login, only: [] do
    resources :contributions, only: %i[index], module: :users
  end
end
