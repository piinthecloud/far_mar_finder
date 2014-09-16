module FarMar
  class Market
    @@csv = CSV.read "./support/markets.csv"
    attr_accessor :id, :name, :address, :city, :county, :state, :zip

    def initialize(array)
      @id = array[0].to_i
      @name = array[1]
      @address = array[2]
      @city = array[3]
      @county = array[4]
      @state = array[5]
      @zip = array[6]
    end

    def self.all
      @@csv.collect { |n| Market.new(n) }
    end

    def self.find(id)
      self.all.find {|m| m.id == id.to_i}
    end

    def vendors
      FarMar::Vendor.all.find_all {|m| m.market_id == @id}
    end

    def products
      array = []
      vendors.each do |vendor|
        collected_products = FarMar::Product.all.find_all {|m| m.vendor_id == vendor.id}
        array << collected_products
      end
      return array.flatten
    end

    def self.search(search_term)
    end

    def preferred_vendor(date) #date optional
    end

    def worst_vendor(date) #date optional
    end

  end
end
