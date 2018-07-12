require 'nokogiri'
require 'open-uri'

def url_depute
  doc = Nokogiri::HTML(open('http://www2.assemblee-nationale.fr/deputes/liste/alphabetique'))
  urls = doc.css('ul.col3 > li > a').map{ |link| link['href'] }
end

def email_depute(url)
  doc = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr#{url}"))
  doc.css('dd')[3].css('ul > li > a').map{|link| link['href'][7..-1]}
end



def infos_deputes
  doc = Nokogiri::HTML(open('http://www2.assemblee-nationale.fr/deputes/liste/alphabetique'))
  names = doc.css('ul.col3 > li > a').map{ |name| name.text }


  first_names = names.map{ |name| name.split[1]}
  last_names =  names.map{ |name| name.split[2..-1].join(' ')}
  p email = url_depute.map{ |url| email_depute(url) }
end

infos_deputes
