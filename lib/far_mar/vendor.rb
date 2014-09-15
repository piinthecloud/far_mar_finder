module FarMar
  class Vendor
    @@csv = CSV.read "./support/vendors.csv"
    attr_accessor :id, :name, :num_employees, :market_id

    def initialize(array)
      @id = array[0]
      @name = array[1]
      @num_employees = array[2]
      @market_id = array[3]
    end

    def self.all
      @@csv.collect { |n| Vendor.new(n) }
    end

    def self.find(id)
      @@csv.find { |m| m[0] == id }
    end
  end
end
