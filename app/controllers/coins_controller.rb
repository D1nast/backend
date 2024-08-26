require 'net/http'
require 'uri'

class CoinsController < ApplicationController
  def index
    uri = URI("https://api.coincap.io/v2/assets?limit=30")
    response = Net::HTTP.get(uri) # HTTP GET リクエストを送信
    render json:response
  end
end
