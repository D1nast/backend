class UsersController < ApplicationController
  include HTTParty
  require 'date'
  require 'json'
  NEWS_API_BASE_URL = 'https://newsapi.org/v2/everything'
  NEWS_API_KEY = ENV['NEWS_API_KEY']
  before_action :authenticate_user,only:[:show]

  def show
    Rails.logger.debug("Session User ID in show action: #{session[:user_id]}")
        # user = User.find(2)
        render json: current_user.as_json(only:[:id,:email,:created_at])
  end
  
# createが成功する条件①６文字以上のパスワードであること②＠マークが１つで、かつ＠マーク以降に.が入力されていること
  def create
    user = User.new(user_params)
    if params_check && checkAtSign && user.save
      render json: { email: user.email }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

# 定期的な仮想通貨関連ニュースを登録されたメールアドレスユーザーに送信する
  def mail
    today = Date.today
    oneago = Date.today - 1
    url = "#{NEWS_API_BASE_URL}?q=bitcoin&from=#{oneago}&to=#{today}&language=en&pageSize=5&sortBy=popularity&apiKey=#{NEWS_API_KEY}"
    response = self.class.get(url, timeout: 10) # タイムアウト時間を10秒に設定
    data = response.parsed_response["articles"]
    extracted_data = data.map do |article|
      {'title' => article['title']}
    end
    user = User.find(2)
    UserMailer.send_mail(user, extracted_data).deliver
  end

  def mail_test
    user = User.find(2)
    UserMailer.send_test(user).deliver
  end

  private
# ↓ストロングパラメータ
  def user_params
    params.require(:user).permit(:email,:password,:password_confirmation)
  end

  # def require_login
  #   if logged_in? == false
  #     render json:{error:'Not authorized'},status:unauthorized
  #   end
  # end
# ↓パスワードが６文字以上かnilじゃないかチェック
  def params_check
    password = params.dig(:user, :password)
    len = password.length
    if len >= 6 && !password.nil?
      return true
    else
      return false
    end 
  end

  # ↓＠の数が1つであることを前提に、＠以降にドットが１つでもあればOK
  def checkAtSign
    email = params.dig(:user,:email)
    len = email.length
    checkAt  = email.index("@") 
    countAt = email.scan("@").length
    if countAt == 1
      afterAt = email.slice(checkAt,len-1)
      if afterAt.include?(".")
        return true
      else
        return false
      end
    end
  end


end