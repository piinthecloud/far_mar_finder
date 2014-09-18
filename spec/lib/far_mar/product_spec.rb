require 'spec_helper'

describe FarMar::Product do

  describe "class methods" do
    it "responds to 'all'" do
      expect(FarMar::Product).to respond_to :all
    end

    it "'all' should return" do
      expect(FarMar::Product.all.count).to eq 8193
    end

    it "responds to 'find'" do
      expect(FarMar::Product).to respond_to :find
    end

    it "responds to 'by_vendor'" do
      expect(FarMar::Product).to respond_to :by_vendor
    end

    it "find the first product by market 1" do
      expect(FarMar::Product.by_vendor(1).first.name).to eq "Dry Beets"
    end

#added test for find_by_x(match) method

    it "responds to 'self.find_by(match, attribute)'" do
      expect(FarMar::Product).to respond_to :find_by
    end

    it "find the product that matches the id attribute and the match string" do
      expect(FarMar::Product.find_by(3, "Id").name).to eq "Heavy Chicken"
    end

    it "find the product that matches the name attribute and the match string" do
      expect(FarMar::Product.find_by("Embarrassed", "NAME").name).to eq "Embarrassed Bread"
    end

    it "find the product that matches the vendor_id attribute and the match string" do
      expect(FarMar::Product.find_by(999, "vendor_id").name).to eq "Shrill Beets"
    end

#added test for find_all_by(match, attribute)
    it "responds to 'self.find_all_by(match, attribute)'" do
      expect(FarMar::Product).to respond_to :find_all_by
    end

    it "find the product that matches the vendor_id attribute and the match string" do
      expect(FarMar::Product.find_all_by(10, "vendor_id").count).to eq 5
    end

    it "find the product that matches the name attribute and the match string" do
      expect(FarMar::Product.find_all_by("Embarrassed", "NAME").count).to eq 23
    end

    it "find the product that matches the id attribute and the match string" do
      expect(FarMar::Product.find_all_by(608, "id")[0].name).to eq "Shrill Beets"
    end

#added test for most_revenue method
    it "responds to 'most_revenue(n)'" do
      expect(FarMar::Product).to respond_to :most_revenue
    end

    it "find the correct number of products with 'most_revenue(n)'" do
      expect(FarMar::Product.most_revenue(5).count).to eq 5
    end

    it "find the correct name of nth product with 'most_revenue(n)'" do
      expect(FarMar::Product.most_revenue(5).last.name).to eq "Embarrassed Beef"
    end
  end

  describe "attributes" do
    let(:product) { FarMar::Product.find(10) }
    # 10,Kertzmann LLC,11,3

    it "has the id 10" do
      expect(product.id).to eq 10
    end

    it "has the name" do
      expect(product.name).to eq "Black Apples"
    end

    it "has the vendor id 5" do
      expect(product.vendor_id).to eq 5
    end
  end

  describe "associations" do
    let(:product) { FarMar::Product.find(62) }

    it "responds to :market" do
      expect(product).to respond_to :vendor
    end

    it "market_id matches the markets id" do
      expect(product.vendor.id).to eq product.vendor_id
    end

    it "responds to :sales" do
      expect(product).to respond_to :sales
    end

    it "has 1 sales" do
      expect(product.sales.count).to eq 2
    end
#added tests for number_of_sales methods
    it "responds to: number_of_sales" do
      expect(product).to respond_to :number_of_sales
    end

    it "has 2 sales" do
      expect(product.number_of_sales).to eq 2
    end

  end

end
