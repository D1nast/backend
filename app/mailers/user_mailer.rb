class UserMailer < ApplicationMailer

  include HTTParty
  NEWS_API_BASE_URL = 'https://newsapi.org/v2/everything'
  NEWS_API_KEY = ENV['NEWS_API_KEY']

  def send_mail(extraced_user)
    @user  = extraced_user
    puts @user.inspect
    @from = "cnCryptnews@outlook.jp"
    @url  = 'cn-cryptnews.com'
    @today = Date.today
    @oneago = Date.today - 2
    @api = "#{NEWS_API_BASE_URL}?q=bitcoin&from=#{@oneago}&to=#{@today}&language=en&pageSize=5&sortBy=popularity&apiKey=#{NEWS_API_KEY}"
    @response = self.class.get(@api, timeout: 10) # タイムアウト時間を10秒に設定
    @data = @response.parsed_response["articles"]
    # urlは、メール本文のテキストに渡す
    # [{"email":"アドレス"},...]のハッシュをそれぞれ渡したい
    # outlookはメール届かない？gmailは動作確認済
    @user.compact.map do |user|
      puts user.inspect
      mail(
        to:user['email'],
        from:"#{@from}",
        subject:"#{@today}     本日の仮想通貨市場のニュースをお届けします"
        )
    end
  end

  def daily_mail

    def getAPI #APIの取得
      today = Date.today
      oneago = Date.today - 2
      api = "#{NEWS_API_BASE_URL}?q=bitcoin&from=#{oneago}&to=#{today}&language=en&pageSize=5&sortBy=popularity&apiKey=#{NEWS_API_KEY}"
      response = self.class.get(api, timeout: 10) # タイムアウト時間を10秒に設定
      data = response.parsed_response["articles"]
      return data
    end
    @extraced_data = getAPI #上記APIの値渡し用

    @from = "cnCryptnews@outlook.jp"
    @url  = 'cn-cryptnews.com'
    @users  = User.all
    @emails = @users.select { |user| user[:deliver] }.map { |user| user[:email] }
    # @emails.map do |user|
    #   puts user
    # mail(
    #   to:user,
    #   from:"#{@from}",
    #   subject:"#{@today}本日の仮想通貨市場のニュースをお届けします"
    #   )
    # end

    mail(
      to:"almond1024r@gmail.com",
      from:"almond1024r@gmail.com",
      subject:"本日の仮想通貨市場のニュースをお届けします"
      )

      puts "Parts: #{parts.inspect}"


  end  
  


end


