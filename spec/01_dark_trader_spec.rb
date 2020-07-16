require_relative '../lib/01_dark_trader.rb'

describe "The html code of the web page" do
  it "should return the html code of web page" do
    expect(acquire_page).not_to be_nil
  end
end

describe "Test on the final hash." do
  final_hash = get_hash
  it "should return a hash containing symbols and prices of crypto-currencies." do
    expect(perform.any?{"BTC" "FX" "NAS"}).to be true
  end
  it "should return an integer larger than 50" do
    expect(final_hash.size).to be>50
  end
end
