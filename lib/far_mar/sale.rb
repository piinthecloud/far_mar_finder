module FarMar
  class Sale
    @@csv = CSV.read "./support/sales.csv"
    attr_accessor :id, :amount, :purchase_time, :vendor_id, :market_id

    def initialize(array)
      @id = array[0]
      @amount = array[1]
      @purchase_time = array[2]
      @vendor_id = array[3]
      @market_id = array[4]
    end

    def self.all
      @@csv.collect { |n| Sale.new(n) }
    end

    def self.find(id)
      @@csv.find { |m| m[0] == id }
    end
  end
end
