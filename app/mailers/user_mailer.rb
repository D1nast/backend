class UserMailer < ApplicationMailer
  
  def send_mail(extraced_user,extracted_data)
    @user  = extraced_user
    @today = Date.today
    @url   = 'cn-cryptnews.com'
    @data  = extracted_data
    # urlは、メール本文のテキストに渡す
    # [{"email":"アドレス"},...]のハッシュをそれぞれ渡したい
    # outlookはメール届かない？gmailは動作確認済
    @user.map do |user|
      mail(
        to:user["email"],
        subject:"#{@today}     本日の仮想通貨市場のニュースをお届けします"
        )
    end

  end


end