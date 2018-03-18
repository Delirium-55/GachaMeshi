require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require 'open-uri'
require 'nokogiri'

get '/' do
  
  #url_id = rand(1111111..9999999) の「1111111」はどんな数字でも7桁を超えなければOK

  def find_html
    base_url = 'https://cookpad.com/recipe/'
    url_id = rand(1000000..9999999)
    url = base_url + url_id.to_s
    begin
      html = open(url).read
    rescue OpenURI::HTTPError => e
      find_html
    end
  end
  
  @links = Array.new
  @imgs = Hash.new
  html = find_html
  parsed_html = Nokogiri::HTML.parse(html,nil,'utf-8')
  @title = parsed_html.css("h1").text.strip
  @zairyou = parsed_html.css("#ingredients_list").text
  @comment= parsed_html.css(".description_text").text
  @step= parsed_html.css("#steps").text
  @kotsu= parsed_html.css("#memo_and_history").text
  erb:index
end

get '/' do
  @links = Array.new
  @imgs = Hash.new
  url = 'https://cookpad.com/recipe/4802178'
  html = open(url).read
  parsed_html = Nokogiri::HTML.parse(html,nil,'utf-8')
  @title2 = parsed_html.css("h1").text.strip
  @zairyou2 = parsed_html.css("#ingredients_list").text
  @comment2= parsed_html.css(".description_text").text
  @step2= parsed_html.css("#steps").text
  @kotsu2= parsed_html.css("#memo_and_history").text
  erb:index
  
end

# ,_＿＿　ラーメンを三ヶ月間茹で続けてやったぜ！！！！！！
# |_＿＿|
#(´・ω・`) ∬
# /　 ゞo＼≠／o　＜老麺
#　しー-J   ￣