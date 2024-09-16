class SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:email].downcase)
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      payload = { message: 'ログインしました。', mail: user.email,id:session[:user_id]}
      Rails.logger.debug("Session User ID after login: #{session[:user_id]}")
    else
      payload = { errors: ['メールアドレスまたはパスワードが正しくありません。'] }
    end
    render json: payload
  end
  
  def destroy
    session.delete(:user_id)
    # session.deleteでログアウト
  end

end
