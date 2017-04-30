Rails.application.routes.draw do
  resources :students, except: %i[new create destroy]
  resources :teachers, only: %i[index show]

  root 'public#index'
end
