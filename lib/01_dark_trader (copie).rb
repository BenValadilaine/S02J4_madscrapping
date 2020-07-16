require 'rspec'
require 'rubocop'
require 'pry'
require 'nokogiri'
require 'open-uri'


def get_page
  page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))
  class_page = page.class
  if class_page = Nokogiri::HTML::Document
    return "HTML code acquired"
  else
    return "Problem occurred while acquirring code"
  end
  return page
end

puts get_page

def get_symbols(page)
  symbol_currency = page.xpath('/html/body/div[1]/div[1]/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[3]/div')
  all_symbols = []
  symbol_currency.each do |symbols|
    all_symbols << symbols.text
  end
  return all_symbols
  puts "Every symbols have been acquired."
end

get_symbols(page)

def get_prices(page)
  price_currency = page.xpath('/html/body/div[1]/div[1]/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[5]/a')
  all_prices = []
  price_currency.each do |prices|
    all_prices << prices.text
  end
  return all_prices
  puts "Every prices have been acquired."
end

get_prices(page)

def arrays_to_hash
  all_symbols = get_symbols
  all_prices = get_prices
  symbols_and_currency = Hash.new
  all_symbols.zip(all_prices){|k,v| symbols_and_currency[k]=v}
  p symbols_and_currency
end

arrays_to_hash
