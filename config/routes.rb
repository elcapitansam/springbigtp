# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  get '/input', to: 'application#input'
  get '/output', to: 'application#output'
  post '/upload', to: 'application#upload'

  root 'batchuploads#input'
end
