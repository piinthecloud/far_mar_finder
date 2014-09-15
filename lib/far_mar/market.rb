module FarMar
  class Market
    @@csv = CSV.read "./support/markets.csv"
    attr_accessor :id, :name, :address, :city, :county, :state, :zip

    def initialize(array)
      @id = array[0].to_i
      @name = array[1]
      @address = array[2]
      @city = array[3]
      @county = array[4]
      @state = array[5]
      @zip = array[6]
    end

    def self.all
      @@csv.collect { |n| Market.new(n) }
    end

    def self.find(id)
      newobject = @@csv.find {|m| m[0].to_i == id.to_i}
      Market.new(newobject)
    end

    def vendors
      CSV.read("./support/vendors.csv").find_all {|m| m[-1] == @id}
    end

  end
end
