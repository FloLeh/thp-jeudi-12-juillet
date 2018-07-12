require 'nokogiri'
require 'open-uri'

def get_the_email_of_a_townhal_from_its_webpage(url)
  doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com#{url}"))
	doc.css('td')[7].text
end

def get_all_the_urls_of_val_doise_townhalls
  doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
  tab = doc.css('p > a').map { |link| link['href'] }
end

def get_all_the_email_of_val_doise_townhalls
  res = []
  doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
  names = doc.css('p > a').map{ |name| name.text }
  emails = get_all_the_urls_of_val_doise_townhalls.map{ |url| get_the_email_of_a_townhal_from_its_webpage(url) }
  names.length.times do |i|
    res += [{ "name" => names[i] , "email" => emails[i] }]
    i += 1
  end
  return res
end

p get_all_the_email_of_val_doise_townhalls
