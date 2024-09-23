Rails.application.routes.draw do

  get '/test', to: 'users#mail'
  get '/' , to: 'coins#index'

  # ユーザーの登録やメール配信解除
  post '/create' , to: 'users#create' 
  post '/change', to: 'users#change'

  get '/news' , to: 'coins#news'
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
