require 'nokogiri'
require 'open-uri'

def trader_obscure
  res=[]
  doc = Nokogiri::HTML(open('https://coinmarketcap.com/all/views/all/'))
  names = doc.css('a.currency-name-container.link-secondary').map{ |name| name.text }
  prices = doc.css('a.price').map{ |price| price.text }
  names.length.times do |i|
    res += [{ 'name' => names[i], 'price' => prices[i] }]
    i += 1
  end
  return res
end

t = Time.now

while 0
  t1 = Time.now
  if t1.min == t.min && t1.sec == t.sec
    p trader_obscure
  end
end
