module FarMar
  class Product
    @@csv = CSV.read "./support/products.csv"
    attr_accessor :id, :name, :vendor_id

    def initialize(array)
      @id = array[0]
      @name = array[1]
      @vendor_id = array[2]
    end

    def self.all
      @@csv.collect { |n| Product.new(n) }
    end

    def self.find(id)
      @@csv.find { |m| m[0] == id }
    end
  end
end
