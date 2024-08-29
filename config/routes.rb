Rails.application.routes.draw do
  get '/' , to: 'coins#index'
  get '/signup' , to: 'users#signup' 
end
