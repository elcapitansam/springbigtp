Rails.application.routes.draw do
  get '/input', to: 'batchuploads#input'
  get '/output', to: 'batchuploads#output'
  post '/upload', to: 'batchuploads#upload'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'batchuploads#input'
end
