Rails.application.routes.draw do
  resources :students, except: %i[new create destroy]
  patch 'students/:id/advance', to: 'students#advance', as: 'advance_student'
  resources :teachers, only: %i[index show]

  root 'public#index'
end
