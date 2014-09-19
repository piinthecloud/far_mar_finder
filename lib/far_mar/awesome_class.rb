module FarMar
  class AwesomeClass

    def self.setpath
      ""
    end

    def self.all
      @csvpath ||= grab
    end

    def self.find(id)
      self.all.find { |m| m.id == id.to_i }
    end

    def self.grab
      CSV.read(self.setpath).collect { |n| self.new(n)}
    end


  end
end
