module FarMar
  class Sale < FarMar::AwesomeClass
    attr_accessor :id, :amount, :purchase_time, :vendor_id, :product_id

    def initialize(array)
      @id = array[0].to_i
      @amount = array[1].to_i
      @purchase_time = DateTime.parse(array[2])
      @vendor_id = array[3].to_i
      @product_id = array[4].to_i
    end

    ATTR_ARRAY = [:id, :amount, :purchase_time, :vendor_id, :product_id]
    CSV = CSV.read("./support/sales.csv").collect { |n| Sale.new(n) }

    def self.all
      CSV_SALE
    end
    #
    # def self.find(id)
    #   self.all.find {|m| m.id == id.to_i}
    # end

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
      if attribute.to_s.include?("id") || attribute.to_s.include?("amount")
        self.all.find { |product| product.send(attribute) == match}
      elsif attribute.to_s.include?("time")
        self.all.find { |product| product.send(attribute).day == DateTime.parse(match).day }
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
      if attribute.to_s.include?("id") || attribute.to_s.include?("amount")
        self.all.find_all { |product| product.send(attribute) == match}
      elsif attribute.to_s.include?("time")
        self.all.find_all { |product| product.send(attribute).day == DateTime.parse(match).day }
      else
        self.all.find_all { |product| product.send(attribute).to_s.downcase.include?(match.to_s.downcase) }
      end
    end

    def self.between(beginning_time, end_time)
      beginning = DateTime.parse(beginning_time)
      ending = DateTime.parse(end_time)

      sale_objects = self.all.sort_by { |sale| sale.purchase_time }
      sale_objects.find_all { |sale| sale.purchase_time.between?(beginning, ending) }
    end

    def vendor
      FarMar::Vendor.find(@vendor_id)
    end

    def product
      FarMar::Product.find(@product_id)
    end
  end
end
