Rails.application.routes.draw do
  get '/' , to: 'coins#index'
  get '/signup' , to: 'users#show'
  post '/create' , to: 'users#create' 
  get '/news' , to: 'coins#news'
end
