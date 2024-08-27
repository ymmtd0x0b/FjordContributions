Rails.application.routes.draw do
  namespace :users, path: '/:user_login' do
    resources :issues, only: %i[index]
    resources :wikis, only: %i[index]
    resources :contributions, only: %i[index]
  end
end
