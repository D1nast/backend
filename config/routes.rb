Rails.application.routes.draw do
  get '/' , to: 'coins#index'
  get '/signup' , to: 'users#signup' 
  get '/news' , to: 'coins#news'
end
