class CoinsController < ApplicationController
  include HTTParty
  base_uri 'https://api.coincap.io/v2/assets'
  def index
    response = self.class.get('?limit=30')
    render json:response.parsed_response
  end
  # 工夫点　１次情報のみ活用した点 Gem作成者のGiHubを見て書いた　２次情報を見ていない
end
