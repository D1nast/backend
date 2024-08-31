require 'open-uri'
require 'json'
require 'date'

url = "https://newsapi.org/v2/everything?q=sol&sortBy=popularity&apiKey=98ff65e5958a47d4a3139a200e9df349"
response = URI.open(url).read
parsed_response = JSON.parse(response)
puts parsed_response