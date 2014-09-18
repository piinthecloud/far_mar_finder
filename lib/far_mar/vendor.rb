module FarMar
  class Vendor
    attr_accessor :id, :name, :no_of_employees, :market_id, :revenue

    def initialize(array)
      @id = array[0].to_i
      @name = array[1]
      @no_of_employees = array[2].to_i
      @market_id = array[3].to_i
      #@revenue = revenue
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

    def self.most_revenue(n)
      holding = []
      self.all.each { |vendor| holding << [vendor, vendor.revenue] }
      sorted = holding.sort_by { |vendor| vendor[1] }.reverse
      sorted[0..n-1].collect {|o| o[0]}
    end

    def self.revenue(date)
      revenue_total = 0
      self.all.each { |vendor| revenue_total += vendor.revenue(date) }
      return revenue_total
    end

    def self.most_items(n)
      holding = []
      self.all.each { |vendor| holding << [vendor, vendor.totalsales] }
      sorted = holding.sort_by { |vendor| vendor[1] }.reverse
      sorted[0..n-1].collect {|o| o[0]}
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

    def totalsales
      sales.count
    end

    def vendor_totals(date)
      date = DateTime.parse(date).day
      sales_array = []
      sales.each { |sale| sales_array << sale.amount if date == sale.purchase_time.day }
      get_total_sum(sales_array)
    end

    def revenue(date=nil)
      if date
        vendor_totals(date)
      else
        total = 0
        sales.each { |sale| total += sale.amount }
        return total
      end
    end

    def get_total_sum(sales_array)
      total = 0
      sales_array.each { |sale| total += sale }
      return total
    end
  end
end
