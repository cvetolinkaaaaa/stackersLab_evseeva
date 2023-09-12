require 'HTTParty'
require 'nokogiri'

category = gets.chomp
url = 'https://www.anekdot.ru/' + category
html = HTTParty.get(url)
doc = Nokogiri::HTML(html)

puts doc.css('.text')[0].text