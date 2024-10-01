Rails.application.routes.draw do
  get 'auth/github/callback', to: 'user_sessions#create'
  get 'auth/failure', to: 'user_sessions#failure'
  delete 'logout', to: 'user_sessions#destroy'
  resource :current_user, only: %i[update destroy] do
    resources :issues, only: %i[index], controller: 'current_user/issues'
    resources :wikis, only: %i[index], controller: 'current_user/wikis'
    resources :contributions, only: %i[index], controller: 'current_user/contributions'
  end
  resources :users, param: :login, only: [] do
    resources :contributions, only: %i[index], controller: 'users/contributions'
  end
end
