class UserMailer < ApplicationMailer
  
  def send_mail(user)
    @user = user
    @today= Date.today
    @url = 'cn-cryptnews.com'
    mail(to:@user.email,subject:"#{@today}     本日の仮想通貨市場のニュースをお届けします")
  end

end
