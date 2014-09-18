require 'spec_helper'

describe FarMar::Vendor do

  describe "class methods" do
    it "responds to 'all'" do
      expect(FarMar::Vendor).to respond_to :all
    end

    it "'all' should return" do
      expect(FarMar::Vendor.all.count).to eq 2690
    end

    it "responds to 'find'" do
      expect(FarMar::Vendor).to respond_to :find
    end

    it "responds to 'by_market'" do
      expect(FarMar::Vendor).to respond_to :by_market
    end

    it "find the first vendor by market 1" do
      expect(FarMar::Vendor.by_market(100).first.name).to eq "Schiller-Ledner"
    end

#added test for find_by_x(match) method
    it "responds to 'self.find_by(match, attribute)'" do
      expect(FarMar::Vendor).to respond_to :find_by
    end

    it "find the vendor that matches the id attribute and the match string" do
      expect(FarMar::Vendor.find_by(3, "Id").name).to eq "Breitenberg Inc"
    end

    it "find the vendor that matches the name attribute and the match string" do
      expect(FarMar::Vendor.find_by("Zulauf", "NAME").name).to eq "Zulauf and Sons"
    end

    it "find the vendor that matches the market_id attribute and the match string" do
      expect(FarMar::Vendor.find_by(12, "market_id").name).to eq "Bernier Inc"
    end

    it "find the vendor that matches the no_of_employees attribute and the match string" do
      expect(FarMar::Vendor.find_by(3, "no_of_employees").name).to eq "Reynolds, Schmitt and Klocko"
    end

# #added test for find_all_by(match, attribute)
    it "responds to 'self.find_all_by(match, attribute)'" do
      expect(FarMar::Vendor).to respond_to :find_all_by
    end

    it "find the vendor that matches the vendor_id attribute and the match string" do
      expect(FarMar::Vendor.find_all_by(8, "id")[0].name).to eq "Stamm Inc"
    end

    it "find the vendors that match the name attribute and the match string" do
      expect(FarMar::Vendor.find_all_by("Parker", "NAME").count).to eq 12
    end

    it "find the vendors that match the market_id attribute and the match string" do
      expect(FarMar::Vendor.find_all_by(12, "market_id").count).to eq 3
    end

    it "find the vendor that matches the no_of_employees attribute and the match string" do
      expect(FarMar::Vendor.find_all_by(3, "no_of_employees").count).to eq 260
    end

#added test for most_revenue method
    it "responds to 'most_revenue(n)'" do
      expect(FarMar::Vendor).to respond_to :most_revenue
    end

    it "find the correct number of vendors with 'most_revenue(n)'" do
      expect(FarMar::Vendor.most_revenue(5).count).to eq 5
    end

    it "find the correct number of vendors with 'most_revenue(n)'" do
      expect(FarMar::Vendor.most_revenue(5).last.name).to eq "Cummings, Orn and Roberts"
    end

#added test for most_items method
    it "responds to 'most_items(n)'" do
      expect(FarMar::Vendor).to respond_to :most_items
    end

    it "find the correct number of vendors with 'most_items(n)'" do
      expect(FarMar::Vendor.most_items(5).count).to eq 5
    end

    it "find the correct name of nth vendor with 'most_items(n)'" do
      expect(FarMar::Vendor.most_items(5).last.name).to eq "Nicolas, Cruickshank and Treutel"
    end

#added test for self.revenue(date) method
    it "responds to 'self.revenue(date)'" do
      expect(FarMar::Vendor).to respond_to :revenue
    end

    it "find the correct total revenue for 'self.revenue(date)'" do
      expect(FarMar::Vendor.revenue("2013-11-13")).to eq 3372020
    end
  end

  describe "attributes" do
    let(:vendor) { FarMar::Vendor.find(10) }
    # 10,Kertzmann LLC,11,3

    it "has the id 10" do
      expect(vendor.id).to eq 10
    end
    it "has the name" do
      expect(vendor.name).to eq "Kertzmann LLC"
    end
    it "has the no of employees 11" do
      expect(vendor.no_of_employees).to eq 11
    end
    it "has the market_id 3" do
      expect(vendor.market_id).to eq 3
    end
  end

  describe "associations" do
    let(:vendor) { FarMar::Vendor.find(1) }

    it "responds to :market" do
      expect(vendor).to respond_to :market
    end

    it "market_id matches the markets id" do
      expect(vendor.market.id).to eq vendor.market_id
    end

    it "responds to :sales" do
      expect(vendor).to respond_to :sales
    end

    it "has 7 sales" do
      expect(vendor.sales.count).to eq 7
    end

    it "responds to products" do
      expect(vendor).to respond_to :products
    end

    it "has 1 products" do
      expect(vendor.products.count).to eq 1
    end

#added tests to revenue method
    it "responds to :revenue" do
      expect(vendor).to respond_to :revenue
    end

    it "has 38259 in revenue" do
      expect(vendor.revenue).to eq 38259
    end

    it "has 38259 in revenue(date)" do
      expect(vendor.revenue("2013-11-10")).to eq 6702
    end
  end
end
