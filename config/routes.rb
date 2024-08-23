Rails.application.routes.draw do
  namespace :user, path: '/:user_login' do
    resources :issues, only: %i[index]
  end
end
