class UserMailer < ApplicationMailer
  
  def send_mail(user,extracted_data)
    @user  = user
    @today = Date.today
    @url   = 'cn-cryptnews.com'
    @data  = extracted_data
    # urlは、メール本文のテキストに渡す
    mail(
      to:@user.email,
      subject:"#{@today}     本日の仮想通貨市場のニュースをお届けします"
      )
  end
end