class UsersController < ApplicationController

  def show 
    user = User.find(1)
    render json: { email: user.email }
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

  private
# ↓ストロングパラメータ
  def user_params
    params.require(:user).permit(:email,:password,:password_confirmation)
  end

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
