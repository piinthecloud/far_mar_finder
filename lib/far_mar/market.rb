module FarMar
  class Market
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

    @@csv = CSV.read("./support/markets.csv").collect { |n| Market.new(n)}

    def self.all
      @@csv
    end

    def self.find(id)
      self.all.find {|m| m.id == id.to_i}
    end

    def self.search(search_term)
      search = search_term.downcase
      array = []
      array << self.all.find_all { |market| market.name.downcase.include?(search) }
      vendors = FarMar::Vendor.all.find_all { |v| v.name.downcase.include?(search) }
      array << lookup_vendor_markets(vendors)
      return array.flatten
    end

    def self.lookup_vendor_markets(vendors)
      vendors.each do |vendor|
        self.all.find_all { |m| m.id == vendor.market_id  }
      end
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

    def preferred_vendor #(date) #date optional
      vendors.max_by { |m| m.revenue}
    end

    def worst_vendor(date) #date optional
    end

  end
end
