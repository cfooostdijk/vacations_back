Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'signin',
    sign_out: 'signout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  namespace :api do
    namespace :v1 do
      resources :employees
      resources :vacations

      post '/import_file', to: 'excel#import', as: 'import_excel'
    end
  end
end
