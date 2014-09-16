module FarMar
  class Product
    @@csv = CSV.read "./support/products.csv"
    attr_accessor :id, :name, :vendor_id

    def initialize(array)
      @id = array[0].to_i
      @name = array[1]
      @vendor_id = array[2].to_i
    end

    def self.all
      @@csv.collect { |n| Product.new(n) }
    end

    def self.find(id)
      self.all.find {|m| m.id == id.to_i}
    end

    def vendor
      FarMar::Vendor.find(@vendor_id)
    end

    def sales
      FarMar::Sale.all.find_all {|m| m.product_id == @id}
    end

    def number_of_sales
      sales.count
    end

    def self.by_vendor(vendor_id)
      self.all.find_all { |m| m.vendor_id == vendor_id }
    end

  end
end
