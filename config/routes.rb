Rails.application.routes.draw do
  resources :instructors, only: [:index, :show, :create, :destroy]
  resources :students, only: [:index, :show, :create, :destroy]
end
