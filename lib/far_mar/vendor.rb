module FarMar
  class Vendor
    @@csv = CSV.read "./support/vendors.csv"
    attr_accessor :id, :name, :no_of_employees, :market_id

    def initialize(array)
      @id = array[0].to_i
      @name = array[1]
      @no_of_employees = array[2].to_i
      @market_id = array[3].to_i
    end

    def self.all
      @@csv.collect { |n| Vendor.new(n) }
    end

    def self.find(id)
      self.all.find {|m| m.id == id.to_i}
    end

    def self.by_market(market_id)

    end

    def market
      FarMar::Market.find(@market_id)
    end

    def products
      FarMar::Product.all.find_all {|m| m.vendor_id == @market_id}
    end

    def sales

    end

    def revenue

    end
  end
end
