require 'rubygems'
require 'nokogiri'
require 'pry'
require 'rspec'
require 'rubocop'
require 'open-uri'


def acquire_page
  page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))
  return page
end


def get_hash
  page = acquire_page
  all_names = page.xpath('/html/body/div[1]/div[1]/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[3]/div')
  all_prices = page.xpath('/html/body/div[1]/div[1]/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[5]/a')

  #Ici on récupère les symboles des CC dans un tableau
  names_list = Array.new
  all_names.each do |name|
    names_list << name.text
  end

  #Ici on récupère les valeurs des CC dans un tableau
  prices_list = Array.new
  all_prices.each do |price|
    prices_list << price.text
  end

  #Ici on récupère toutes les données dans un seul grand hash
  final_list = Hash.new
  names_list.zip(prices_list){|k,v|final_list[k] = v}

  #Ici on sépare le grand hash 'final_list' en un tableau contenant plusieurs petits hash composés du symbole et de la valeur de la CC
  final_hash = final_list.each_slice(1).map(&:to_h)
  puts final_hash
  return final_hash
end

def perform
  acquire_page
  get_hash
end

perform
