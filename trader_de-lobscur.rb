require 'rubygems'
require 'nokogiri'
require 'open-uri'

def crypto(url)
    crypto = {}
    page = Nokogiri::HTML(open(url))
    crypto[:noms] = page.xpath('/html/body/div[2]/div/div[1]/div[3]/div[1]/h1/text()').text.strip()
    crypto[:cours] = page.xpath('//*[@id="quote_price"]/span[1]').text
    crypto
end
def urlcrypto(url)
  doc = Nokogiri::HTML(open(url))
  cryptomonnaies = []
  doc.xpath('//a[@class = "link-secondary"]/@href').each do |url|#on prend la fin de l url dans le xpath
    aa = crypto("https://coinmarketcap.com" + url.text)#on appelle la methode et  on utilise une variable intermediaire pour alleger le process et on ajoute la fin de l url pour avoir l url complete
    cryptomonnaies << aa
   end
  return cryptomonnaies
end

 p urlcrypto("https://coinmarketcap.com/all/views/all/")
