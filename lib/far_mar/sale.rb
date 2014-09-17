module FarMar
  class Sale
    attr_accessor :id, :amount, :purchase_time, :vendor_id, :product_id

    def initialize(array)
      @id = array[0].to_i
      @amount = array[1].to_i
      @purchase_time = DateTime.parse(array[2])
      @vendor_id = array[3].to_i
      @product_id = array[4].to_i
    end

    @@csv = CSV.read("./support/sales.csv").collect { |n| Sale.new(n) }

    def self.all
      @@csv
    end

    def self.find(id)
      self.all.find {|m| m.id == id.to_i}
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
