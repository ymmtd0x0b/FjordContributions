Rails.application.routes.draw do
  get 'auth/github/callback', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  resource :current_user, only: %i[update destroy], controller: 'current_user'
  namespace :current_user do
    resources :issues, only: %i[index]
    resources :wikis, only: %i[index]
    resources :contributions, only: %i[index]
  end
  namespace :users, path: '/:user_login' do
    resources :contributions, only: %i[index]
  end
end
