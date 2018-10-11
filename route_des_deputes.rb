require 'rubygems'
require 'nokogiri'
require 'open-uri'

def get_contact (contact_url)
  contact = {}
  page = Nokogiri::HTML(open(contact_url))
  complete_name = page.xpath('//*[@id="haut-contenu-page"]/article/div[2]/h1').text.split
  contact[:firstname] = complete_name[1]
  contact[:name] = complete_name[2]
  contact[:mail] = page.xpath('//*[@id="deputes-contact"]/section/dl/dd[1]/a/@href').text.split(":")[1]
  contact # {name: nom, firstname: prenom, email: mail}
end


def get_all_the_urls_of_the_deputies(website, page)
  urls = []
  page = Nokogiri::HTML(open(website + page)) #on prend que l url du site web principal et la fin de l url
  page.xpath('//*[@id="deputes-list"]/div/ul/li/a/@href').each do |deputy|
    urls << website + deputy.text #on prend l url du site et on ajoute la page contact du depute pour avoir l url du depute
  end
  urls
end

def get_all_deputies_contacts(website, page)
  contacts_list = []
  urls = get_all_the_urls_of_the_deputies(website, page)
  urls.each do |url|
    contacts_list << get_contact(url)
  end
  contacts_list
end

#p get_contact("http://www2.assemblee-nationale.fr/deputes/fiche/OMC_PA609520")
puts get_all_deputies_contacts("http://www2.assemblee-nationale.fr", "/deputes/liste/alphabetique")# on separe l url de la page principale du site , de le liste des deputes
