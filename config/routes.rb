Rails.application.routes.draw do

  get '/test', to: 'users#mail'
  get '/' , to: 'coins#index'
  post '/create' , to: 'users#create' 
  get '/news' , to: 'coins#news'
  # ユーザーページ表示
  get   '/user', to: 'users#show'

  namespace :api  do
    namespace :v1 do
      resources :auth_token,  only:[:create] do
        post   :refresh, on:  :collection
        delete :destroy, on:  :collection
      end
    end
  end
  
end
