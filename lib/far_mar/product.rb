module FarMar
  class Product
    attr_accessor :id, :name, :vendor_id

    def initialize(array)
      @id = array[0].to_i
      @name = array[1]
      @vendor_id = array[2].to_i
    end

    CSV_PRODUCT = CSV.read("./support/products.csv").collect { |n| Product.new(n) }

    def self.all
      CSV_PRODUCT
    end

    def self.find(id)
      self.all.find {|m| m.id == id.to_i}
    end

# This is our method for self.find_by_x(match) for the Gold Level
    def self.find_by(match, attribute)
      attribute = attribute.downcase.to_sym
      if [:id, :name, :vendor_id].include?(attribute)
        self.all.find { |product| product.send(attribute).to_s.downcase.include?(match.to_s.downcase) }
      else
        puts "Try a different attribute."
      end
    end

    def self.by_vendor(vendor_id)
      self.all.find_all { |m| m.vendor_id == vendor_id }
    end

    def self.most_revenue(n)
      holding = []
      self.all.each { |product| holding << [product, product.total_sales] }
      sorted = holding.sort_by { |product| product[1] }.reverse
      sorted[0..n-1].collect {|o| o[0]}
    end

    def vendor
      FarMar::Vendor.find(@vendor_id)
    end

    def sales
      FarMar::Sale.all.find_all {|m| m.product_id == @id}
    end

    def total_sales
      total = 0
      sales.each { |sale| total += sale.amount }
      return total
    end

    def number_of_sales
      sales.count
    end
  end
end
