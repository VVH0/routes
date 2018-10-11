  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'

def get_the_email_of_a_townhal_from_its_webpage(mairie)
  email = {}
  page = Nokogiri::HTML(open(mairie))
  email["name"] = page.xpath('/html/body/div/main/section[1]/div/div/div/p[1]/strong[1]/a').text
  email["mail"] = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
  return email
end

def get_all_the_urls_of_val_doise_townhalls
 doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
 mairies = []
 doc.xpath('//a[@class = "lientxt"]/@href').each do |mairie|
   mairie = "http://annuaire-des-mairies.com" + mairie.to_s[1..-1]#on appelle la methode et  on utilise une variable intermediaire pour alleger le process et on ajoute la fin de l url pour avoir l url complete et on enleve le point devant
   mairies << get_the_email_of_a_townhal_from_its_webpage(mairie)#pour chaque url on va rechercher les mails que l on injecte dans notre tableau mairie
 end
 return mairies
end

p get_all_the_urls_of_val_doise_townhalls()
