Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :employees
      resources :vacations
    end
  end
end
