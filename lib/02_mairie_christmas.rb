require 'rubygems'
require 'nokogiri'
require 'pry'
require 'rspec'
require 'rubocop'
require 'open-uri'

#Here we get Avernes' townhall email.
def get_townhall_email(urls_list)
  page = Nokogiri::HTML(URI.open(urls_list))
  townhall_email = page.xpath('/html/body/div[1]/main/section[2]/div/table/tbody/tr[4]/td[2]')
  return townhall_email.text
end

#Here we get every Val d'Oise townhall emails.
def get_townhall_urls
  page = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/val-d-oise.html"))
  townhall_url = page.xpath('//a[contains(@href, "./")]')

  #p names_list
  urls_list = Array.new
  townhall_url.each do |i|
    urls_list << "http://annuaire-des-mairies.com/" + (i[:href])[2..-1]
  end # -> Town urls
  return urls_list
end

#Heer we get every Val d'Oise town names
def get_townhall_names
  page = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/val-d-oise.html"))
  townhall_url = page.xpath('//a[contains(@href, "./")]')

  #puts townhall_url
  names_list = Array.new
  townhall_url.each do |names|
    names_list << names.text
  end #-> Town names
  return names_list
end

#This method's purpose is to launch other methods.
def perform
  emails_list = Array.new
  get_townhall_urls.each do |url|
    emails_list << get_townhall_email(url)
  end

  #Here we join two lists : names_list returned by get_townhall_names plus emails_list
  composed_hash = Hash.new
  get_townhall_names.zip(emails_list){|k,v|composed_hash[k] = v}
  #p composed_hash

  #Here we decompose both hashes into one big array.
  final_hash = composed_hash.each_slice(1).map(&:to_h)
  p final_hash
end

perform
