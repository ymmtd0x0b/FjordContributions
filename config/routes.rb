Rails.application.routes.draw do
  namespace :users, path: '/:user_login' do
    resources :issues, only: %i[index]
  end
end
