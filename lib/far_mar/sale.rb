module FarMar
  class Sale
    @@csv = CSV.read "./support/sales.csv"
    attr_accessor :id, :amount, :purchase_time, :vendor_id, :product_id

    def initialize(array)
      @id = array[0].to_i
      @amount = array[1].to_i
      @purchase_time = DateTime.parse(array[2])
      @vendor_id = array[3].to_i
      @product_id = array[4].to_i
    end

    def self.all
      @@csv.collect { |n| Sale.new(n) }
    end

    def self.find(id)
      self.all.find {|m| m.id == id.to_i}
    end

    def self.between(beginning_time, end_time)

    end

    def vendor
      FarMar::Vendor.find(@vendor_id)
    end

    def product

    end
  end
end
