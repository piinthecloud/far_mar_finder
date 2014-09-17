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

    it "returns preferred_vendor" do
      expect(market.preferred_vendor.name).to eq "Reynolds, Schmitt and Klocko"
    end

# added tests for worst_vendor
    it "responds to worst_vendor" do
      expect(FarMar::Market.new({})).to respond_to :worst_vendor
    end

    it "returns worst_vendor" do
      expect(market.worst_vendor.name).to eq "Zulauf and Sons"
    end

    it "returns preferred_vendor (date)" do
      expect(market.preferred_vendor(date).name).to eq "Reynolds, Schmitt and Klocko"
    end

  end
end
