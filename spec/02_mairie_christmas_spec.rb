require_relative '../lib/02_mairie_christmas.rb'

describe "get_townhall_urls get the url of every townhalls from Val d'Oise" do
  it "should return an array of urls" do
    expect(get_townhall_urls).not_to be_nil
    expect(get_townhall_urls.any?{"http://annuaire-des-mairies.com/95/frepillon.html"}).to be true
  end
end

describe "get_townhall_names get the name of every townhalls from Val d'Oise" do
  it "should return an array of names" do
    expect(get_townhall_names).not_to be_nil
    expect(get_townhall_names.any?{"Frepillon" "Gonesse"}).to be true
    expect(get_townhall_names.size).to be == 185
  end
end

#This last describe tests presence of both emails and names of townhalls in the last array.
describe "get_townhall_email get the name of every townhalls from Val d'Oise" do
  it "should return an array of emails" do
    expect(perform).not_to be_nil
    expect(perform.any?{"mairie@attainville.fr" "mairie.le.heaulme@cegetel.net
      " "Sagy" "Us"}).to be true
      expect(perform.size).to eq(185)
    end
  end
