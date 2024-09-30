class UsersController < ApplicationController
  include HTTParty
  require 'date'
  require 'json'
  NEWS_API_BASE_URL = 'https://newsapi.org/v2/everything'
  NEWS_API_KEY = ENV['NEWS_API_KEY']
  before_action :authenticate_user,only:[:show]
  
# createが成功する条件①６文字以上のパスワードであること②＠マークが１つで、かつ＠マーク以降に.が入力されていること
  def create
    user = User.new(user_params)
    if params_check && checkAtSign && user.save
      render json: { email: user.email }, status: :created
      UserMailer.register_user(user.email).deliver
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # メール配信を解除する
  # ユーザーが見つからなければその時点で処理取りやめ
  def change
    user = User.find_by(email:user_params[:email])
    if user.deliver == true
      user.deliver=false
      user.save
      render json:"メールの配信を解除しました"
    else
      user.deliver=true
      user.save
      render json:"メールの配信を登録しました"
    end
  end

  def delete
    user = User.find_by(email:user_params[:email])
    # userでレコードを全て取得
    UserMailer.delete_user(user.email).deliver
    user.destroy
  end

# 定期的な仮想通貨関連ニュースを登録されたメールアドレスユーザーに送信する
# 課題：①本番環境に合わせていくことと　②取得したアドレス全件に送っていくこと
# リンクつけると弾かれる
# 定期的な配信になっていない
  def mail
    # テーブルから全ての登録ユーザーを洗い出して、deliverがtrueの顧客にメールアドレスを
    userList = User.all
    extraced_user = userList.map do |user|
      if user.deliver
        {'email' => user['email']}
      end
    end
    puts extraced_user
    UserMailer.daily_mail(extraced_user).deliver
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
  

  #  ↓パスワードが６文字以上かnilじゃないかチェック
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