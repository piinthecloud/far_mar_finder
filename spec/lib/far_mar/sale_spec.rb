require 'spec_helper'
describe FarMar::Sale do

  describe "class methods" do
    it "responds to 'all'" do
      expect(FarMar::Sale).to respond_to :all
    end

    it "'all' should return" do
      expect(FarMar::Sale.all.count).to eq 12798
    end

    it "responds to 'find'" do
      expect(FarMar::Sale).to respond_to :find
    end

    it "responds to 'between'" do
      expect(FarMar::Sale).to respond_to :between
    end

#Added to test for self.between method
    it "'between' should return" do
      expect(FarMar::Sale.between("2013-11-09T19:00:48-08:00", "2013-11-09T19:04:08-08:00").count).to eq 3
    end
  end

  describe "attributes" do
    let(:sale) { FarMar::Sale.find(1) }
    # 1,People's Co-op Farmers FarMar::Sale,30,Portland,Multnomah,Oregon,97202

    it "has the id 1" do
      expect(sale.id).to eq 1
    end

    it "has the amount in cents 9290" do
      expect(sale.amount).to eq 9290
    end

    it "has the day 31" do
      expect(sale.purchase_time.day).to eq 7
    end

    it "has the vendor_id 1" do
      expect(sale.vendor_id).to eq 1
    end

    it "has the product_id 1" do
      expect(sale.product_id).to eq 1
    end
  end

  describe "instance methods" do
    let(:sale) { FarMar::Sale.find(1) }
    it "responds to vendor" do
      expect(sale).to respond_to :vendor
    end

    it "has the vendor" do
      expect(sale.vendor.id).to eq sale.vendor_id
    end
    
    it "responds to product" do
      expect(sale).to respond_to :product
    end

    it "has the product" do
      expect(sale.product.id).to eq sale.product_id
    end
  end
end
