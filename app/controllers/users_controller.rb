class UsersController < ApplicationController
  def signup
    user = User.create(name:"ああ",email:"aa") #フロントとAPI通信するなら下のparamsを入れる
    head :created
    user.save
  end

  private

  def signup_params
    params.require(:user).permit(:name,:email)
  end
end
