Rails.application.routes.draw do
  get 'batchuploads/input'
  get 'batchuploads/output'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :records, only: [:index, :new, :create]
  root 'records#index'
end
