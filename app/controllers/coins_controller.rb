class CoinsController < ApplicationController
  include HTTParty
  
  NEWS_API_BASE_URL = 'https://newsapi.org/v2/everything'
  NEWS_API_KEY = ENV['NEWS_API_KEY']

  def index
    response = self.class.get('https://api.coincap.io/v2/assets?limit=30')
    render json:response.parsed_response
  end
  # 工夫点　１次情報のみ活用した点 Gem作成者のGiHubを見て書いた　２次情報を見ていない

  def news
    
    url = "#{NEWS_API_BASE_URL}?q=bitcoin&sortBy=poularity&apiKey=#{NEWS_API_KEY}"
    response = self.class.get(url)
    render json:response.parsed_response
  end
end
