Rails.application.routes.draw do
  get 'students', to: 'students#index'
  get 'students/:id', to: 'students#show', as: 'student'
  get 'students/:id/edit', to: 'students#edit', as: 'edit_student'
  put 'students/:id', to: 'students#update'
  patch 'students/:id', to: 'students#update'

  root 'public#index'
end
