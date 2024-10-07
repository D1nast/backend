class UserMailer < ApplicationMailer

  include HTTParty
  NEWS_API_BASE_URL = 'https://newsapi.org/v2/everything'
  NEWS_API_KEY = ENV['NEWS_API_KEY']

  # 毎日朝７時にメール仮想通貨のマーケット情報のメールを送信する
  def daily_mail(extraced_user)

    def getAPI #APIの取得
      today = Date.today
      oneago = Date.today - 2
      api = "#{NEWS_API_BASE_URL}?q=bitcoin&from=#{oneago}&to=#{today}&language=en&pageSize=5&sortBy=popularity&apiKey=#{NEWS_API_KEY}"
      response = self.class.get(api, timeout: 10) # タイムアウト時間を10秒に設定
      data = response.parsed_response["articles"]
      puts data
      return data
    end

    @extraced_data = getAPI #上記APIの値渡し用
    @from = "cncryptnews@gmail.com"
    @url  = 'cn-cryptnews.com'
    @users  = User.all
    @emails = @users.select { |user| user[:deliver] }.map { |user| user[:email] }
    @emails.map do |user|
      puts user
    mail(
      to:user,
      from:"#{@from}",
      subject:"#{@today}本日の仮想通貨市場のニュースをお届けします"
      )
    end
  end  
  
  #　ユーザーを削除した場合、メールを送る
  def delete_user(user)
    @from = "cncryptnews@gmail.com"
    @url  = 'cn-cryptnews.com'
    @email = user
    mail(
      to:@email,
      from:@from,
      subject:"ユーザー削除の処理が完了しました"
    )
  end

  # ユーザーを登録した場合、メールをお送る 
  def register_user(user)
    @from = "cncryptnews@gmail.com"
    @url  = 'cn-cryptnews.com'
    @email = user
    mail(
      to:@email,
      from:@from,
      subject:"ユーザー登録ありがとうございます！"
    )
  end

end


