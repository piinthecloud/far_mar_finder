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

    CSV_MARKET = CSV.read("./support/markets.csv").collect { |n| Market.new(n)}

    def self.all
      CSV_MARKET
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

    def worst_vendor #(date) #date optional
      vendors.min_by { |m| m.revenue}
    end


    def pref_vendor_test(date)
      newsales_ar = []
      vendors.each do |vendor|
        newsales_ar << [vendor, vendor.pref_vendor(date, vendor)]
      end
      newsales_ar.max_by {|array| array[1]}
    end

    def pref_vendor(date, vendor)
      x = FarMar::Sales.all.find_all {|m| m.vendor_id == vendor.id}
      sales_array = []
      x.each do |sale|
        if date == sale.purchase_time
          sales_array << sale
        end
      end

      total = 0
      sales_array.each do |sale|
        total += sale
      end
      return total


    end
  end
end
