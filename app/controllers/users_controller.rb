class UsersController < ApplicationController

  def show 
    user = User.find(1)
    render json: { email: user.email }
  end

  def create
    user = User.new(user_params)
    if params_check && user.save
      render json: { email: user.email }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
# ↓ストロングパラメータ
  def user_params
    params.require(:user).permit(:email,:password)
  end

# ↓パスワードが６文字以上かnilじゃないかチェック
  def params_check
    password = params[:password]
    len = password.length
    if len >=6 && !password.nil?
      return true
    else
      return false
    end 
  end

  # ↓"@"と"."をもち、且つ"."が一つでも"@"の後ろにあれば登録する
  def checkAtSign
    email = params[:email]
    checkDot = email.index(".")
    checkAt  = email.index("@")
    
    if email.include?("@") && email.inclide?(".") && checkAt < checkDot
      return true
    else
      return false
    end
  end

end
