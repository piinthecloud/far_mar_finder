module FarMar
  class Vendor
    @@csv = CSV.read "./support/vendors.csv"
    attr_accessor :id, :name, :num_employees, :market_id

    def initialize(array)
      @id = array[0].to_i
      @name = array[1]
      @num_employees = array[2]
      @market_id = array[3].to_i
    end

    def self.all
      @@csv.collect { |n| Vendor.new(n) }
    end

    def self.find(id)
      self.all.find {|m| m.id == id.to_i}
    end
  end
end
