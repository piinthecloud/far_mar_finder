module FarMar
  class AwesomeClass
   CSV = []

    def self.all
      CSV
    end

    def self.find(id)
      self.all.find { |m| m.id == id.to_i }
    end
  end
end
