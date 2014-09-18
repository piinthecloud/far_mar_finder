require 'spec_helper'
describe FarMar::Market do

  describe "class methods" do

# added tests for self.search
    it "responds to 'search'" do
      expect(FarMar::Market).to respond_to :search
    end

    it "'search' should return" do
      expect(FarMar::Market.search('john').count).to eq 29
    end

    it "responds to 'all'" do
      expect(FarMar::Market).to respond_to :all
    end

    it "'all' should return" do
      expect(FarMar::Market.all.count).to eq 500
    end

    it "responds to 'find'" do
      expect(FarMar::Market).to respond_to :find
    end

#added test for find_by_x(match) method
    it "responds to 'self.find_by(match, attribute)'" do
      expect(FarMar::Market).to respond_to :find_by
    end

    it "find the market that matches the id attribute and the match string" do
      expect(FarMar::Market.find_by(3, "Id").name).to eq "Dolgeville Farmer's Market"
    end

    it "find the market that matches the name attribute and the match string" do
      expect(FarMar::Market.find_by("Plaza", "name").name).to eq "Plaza Marketplace"
    end

    it "find the market that matches the address attribute and the match string" do
      expect(FarMar::Market.find_by("Parkway", "address").name).to eq "Quincy Farmers Market"
    end

    it "find the market that matches the city attribute and the match string" do
      expect(FarMar::Market.find_by("Travelers", "city").name).to eq "TRAVELERS REST COMMUNITY FARMERS MARKET"
    end

    it "find the market that matches the county attribute and the match string" do
      expect(FarMar::Market.find_by("Henry", "county").name).to eq "Henry County Farmers Market"
    end

    it "find the market that matches the state attribute and the match string" do
      expect(FarMar::Market.find_by("Texas", "state").name).to eq "Farmers Market in Denison"
    end

    it "find the market that matches the zip attribute and the match string" do
      expect(FarMar::Market.find_by(5494, "zip").name).to eq "Farmers Market on the Westford Common"
    end
#
# #added test for find_all_by(match, attribute)
    it "responds to 'self.find_all_by(match, attribute)'" do
      expect(FarMar::Market).to respond_to :find_all_by
    end

    it "find the market that matches the id attribute and the match string" do
      expect(FarMar::Market.find_all_by(450, "Id")[0].name).to eq "Sunblest"
    end

    it "find the markets that match the name attribute and the match string" do
      expect(FarMar::Market.find_all_by("Downtown", "name").count).to eq 20
    end

    it "find the markets that match the address attribute and the match string" do
      expect(FarMar::Market.find_all_by("Route", "address").count).to eq 4
    end

    it "find the markets that match the city attribute and the match string" do
      expect(FarMar::Market.find_all_by("gaylord", "city").count).to eq 2
    end

    it "find the market that matches the county attribute and the match string" do
      expect(FarMar::Market.find_all_by("Henry", "county").count).to eq 4
    end

    it "find the markets that matches the state attribute and the match string" do
      expect(FarMar::Market.find_all_by("Texas", "state").count).to eq 23
    end

    it "find the market that matches the zip attribute and the match string" do
      expect(FarMar::Market.find_all_by(60098, "zip").count).to eq 2
    end
  end

  describe "attributes" do
    let(:market) { FarMar::Market.find(1) }
    # 1,People's Co-op Farmers FarMar::Market,30,Portland,Multnomah,Oregon,97202

    it "has the id 1" do
      expect(market.id).to eq 1
    end

    it "has the name 'People's Co-op Farmers FarMar::Market'" do
      expect(market.name).to eq "People's Co-op Farmers Market"
    end

    it "has the address '30th and Burnside'" do
      expect(market.address).to eq "30th and Burnside"
    end

    it "has the city 'Portland'" do
      expect(market.city).to eq "Portland"
    end
    it "has the county 'Multnomah'" do
      expect(market.county).to eq "Multnomah"
    end
    it "has the state 'Oregon'" do
      expect(market.state).to eq "Oregon"
    end
    it "has the zip '97202'" do
      expect(market.zip).to eq "97202"
    end

  end

  describe "instance methods" do
    let(:market) { FarMar::Market.find(1) }
    it "responds to vendors" do
      expect(FarMar::Market.new({})).to respond_to :vendors
    end

    it "finds the vendors" do
      expect(market.vendors.first.id).to eq 1
    end

# added tests for products method in markets.rb
    it "responds to products" do
      expect(FarMar::Market.new({})).to respond_to :products
    end

    it "returns products available at the market" do
      expect(market.products.first.id).to eq 1
    end

# added tests for preferred_vendor
    it "responds to preferred_vendor" do
      expect(FarMar::Market.new({})).to respond_to :preferred_vendor
    end

    it "returns preferred_vendor overall" do
      expect(market.preferred_vendor.name).to eq "Reynolds, Schmitt and Klocko"
    end

    it "returns preferred_vendor(date)" do
      expect(market.preferred_vendor("2013-11-10").name).to eq "Breitenberg Inc"
    end

# added tests for worst_vendor
    it "responds to worst_vendor" do
      expect(FarMar::Market.new({})).to respond_to :worst_vendor
    end

    it "returns worst_vendor overall" do
      expect(market.worst_vendor.name).to eq "Zulauf and Sons"
    end

    it "returns worst_vendor(date)" do
      expect(market.worst_vendor("2013-11-10").count).to eq 2
    end
  end
end
