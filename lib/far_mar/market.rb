module FarMar
  class Market
    def initialize
      @csv = CSV.read "./support/markets.csv"
    end
    def self.all
      CSV.read "./support/markets.csv"
    end
    def self.find(id)
      @csv.find {|m| m[0] == id}
    end
  end
end
