require 'rubygems'
require 'nokogiri'
require 'pry'
require 'rspec'
require 'rubocop'
require 'open-uri'

page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))

def acquire_page(page)
  classpage = page.class
  if classpage = Nokogiri::HTML::Document
    return "The page is ready to be scrapped"
  else
    return "Problem occurred"
  end
end

puts acquire_page(page)

def get_names(page)
  all_names = page.xpath('/html/body/div[1]/div[1]/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[3]/div')
  #puts all_names
  names_list = Array.new
  all_names.each do |name|
    names_list << name.text
  end
  return names_list
end

names = get_names(page)
#print names

def get_prices(page)
  all_prices = page.xpath('/html/body/div[1]/div[1]/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[5]/a')
  #puts all prices

  prices_list = Array.new
  all_prices.each do |price|
    prices_list << price.text
  end
  return prices_list
end

prices = get_prices(page)
#print prices

def get_final_hash(names, *prices)
  final_list = Hash.new
  names.zip(prices){|k,v|final_list[k] = v}

  final_hash = final_list.each_slice(1).map(&:to_h)
  return final_hash
end

get_final_hash(names, prices)
