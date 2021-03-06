module FarMar
  class Product < FarMar::AwesomeClass
    attr_accessor :id, :name, :vendor_id

    def self.setpath
      "./support/products.csv"
    end

    def initialize(array)
      @id        = array[0].to_i
      @name      = array[1]
      @vendor_id = array[2].to_i
    end

    ATTR_ARRAY = [:id, :name, :vendor_id]

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
      if attribute.to_s.include?("id")
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
      if attribute.to_s.include?("id")
        self.all.find_all { |product| product.send(attribute) == match}
      else
        self.all.find_all { |product| product.send(attribute).to_s.downcase.include?(match.to_s.downcase) }
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
