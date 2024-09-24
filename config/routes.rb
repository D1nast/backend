Rails.application.routes.draw do

  get '/test', to: 'users#mail'
  get '/' , to: 'coins#index'

  # ユーザー登録
  post '/create' , to: 'users#create' 
  # メール配信の停止・再開
  post '/change', to: 'users#change'
  # ユーザー登録の削除
  post '/delete', to: 'users#delete'

  get '/news' , to: 'coins#news'

  namespace :api  do
    namespace :v1 do
      resources :auth_token,  only:[:create] do
        post   :refresh, on:  :collection
        delete :destroy, on:  :collection
      end
    end
  end
  
end
