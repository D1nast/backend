Rails.application.routes.draw do

  get '/' , to: 'coins#index'
  post '/create' , to: 'users#create' 
  get '/news' , to: 'coins#news'

  # ログイン、ログアウト
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  # ユーザーページ表示
  get   '/user', to: 'users#show'
  
end
