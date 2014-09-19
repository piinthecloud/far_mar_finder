module FarMar
  class Vendor < FarMar::AwesomeClass
    attr_accessor :id, :name, :no_of_employees, :market_id

    def self.setpath
      "./support/vendors.csv"
    end

    def initialize(array)
      @id              = array[0].to_i
      @name            = array[1]
      @no_of_employees = array[2].to_i
      @market_id       = array[3].to_i
    end

    ATTR_ARRAY = [:id, :name, :no_of_employees, :market_id]

# This is our method for self.find_by_x(match) for the Gold Level
    def self.find_by(match, attribute)
      attribute = attribute.downcase.to_sym
      if ATTR_ARRAY.include?(attribute)
        self.find_by_results(match, attribute)
      else
        puts "Try a different attribute."
      end
    end

    def self.find_by_results(match, attribute)
      if attribute.to_s.include?("id") || attribute.to_s.include?("no_of_employees")
        self.all.find { |product| product.send(attribute) == match}
      else
        self.all.find { |product| product.send(attribute).to_s.downcase.include?(match.to_s.downcase) }
      end
    end


    def self.find_all_by(match, attribute)
      attribute = attribute.downcase.to_sym
      if ATTR_ARRAY.include?(attribute)
        self.find_all_by_results(match, attribute)
      else
        puts "Try a different attribute."
      end
    end

    def self.find_all_by_results(match, attribute)
      if attribute.to_s.include?("id") || attribute.to_s.include?("no_of_employees")
        self.all.find_all { |product| product.send(attribute) == match}
      else
        self.all.find_all { |product| product.send(attribute).to_s.downcase.include?(match.to_s.downcase) }
      end
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
