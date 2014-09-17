module FarMar
  class Vendor
    attr_accessor :id, :name, :no_of_employees, :market_id

    def initialize(array)
      @id = array[0].to_i
      @name = array[1]
      @no_of_employees = array[2].to_i
      @market_id = array[3].to_i
      # @revenue = revenue
    end

    CSV_VENDOR = CSV.read("./support/vendors.csv").collect { |n| Vendor.new(n)}

    def self.all
      CSV_VENDOR
    end

    def self.find(id)
      self.all.find { |m| m.id == id.to_i }
    end

    def self.by_market(market_id)
      self.all.find_all { |m| m.market_id == market_id }
    end

    def market
      FarMar::Market.find(@market_id)
    end

    def products
      FarMar::Product.all.find_all { |m| m.vendor_id == @id }
    end

    def sales
      FarMar::Sale.all.find_all { |m| m.vendor_id == @id }
    end

    def revenue
      total = 0
      sales.each { |sale| total += sale.amount }
      return total
    end

    def vendor_totals(date, vendor)
      date = DateTime.parse(date)
      x = FarMar::Sale.all.find_all {|m| m.vendor_id == vendor.id}
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
