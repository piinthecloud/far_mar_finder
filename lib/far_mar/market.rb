module FarMar
  class Market < FarMar::AwesomeClass
    attr_accessor :id, :name, :address, :city, :county, :state, :zip

    def self.setpath
      "./support/markets.csv"
    end

    def initialize(array)
      @id       = array[0].to_i
      @name     = array[1]
      @address  = array[2]
      @city     = array[3]
      @county   = array[4]
      @state    = array[5]
      @zip      = array[6]
    end

    ATTR_ARRAY = [:id, :name, :address, :city, :county, :state, :zip]

    def self.search(search_term)
      search = search_term.downcase
      array = []
      array << self.all.find_all { |market| market.name.downcase.include?(search) }
      vendors = FarMar::Vendor.all.find_all { |v| v.name.downcase.include?(search) }
      array << lookup_vendor_markets(vendors)
      return array.flatten
    end

# This is our method for self.find_by_x(match) for the Gold Level
    def self.find_by(match, attribute)
      attribute = attribute.downcase.to_sym
      if ATTR_ARRAY.include?(attribute)
        self.find_by_results(match, attribute)
      else
        puts "Try a different attribute."
      end
    end

    def self.find_by_results(match, attribute)
      if attribute.to_s.include?("id")
        self.all.find { |product| product.send(attribute) == match}
      else
        self.all.find { |product| product.send(attribute).to_s.downcase.include?(match.to_s.downcase) }
      end
    end

    def self.find_all_by(match, attribute)
      attribute = attribute.downcase.to_sym
      if ATTR_ARRAY.include?(attribute)
        self.find_all_by_results(match, attribute)
      else
        puts "Try a different attribute."
      end
    end

    def self.find_all_by_results(match, attribute)
      if attribute.to_s.include?("id")
        self.all.find_all { |product| product.send(attribute) == match}
      else
        self.all.find_all { |product| product.send(attribute).to_s.downcase.include?(match.to_s.downcase) }
      end
    end

    def self.lookup_vendor_markets(vendors)
      vendors.each do |vendor|
        self.all.find_all { |m| m.id == vendor.market_id  }
      end
    end

    def vendors
      FarMar::Vendor.all.find_all {|m| m.market_id == @id}
    end

    def products
      array = []
      vendors.each do |vendor|
        collected_products = FarMar::Product.all.find_all {|m| m.vendor_id == vendor.id}
        array << collected_products
      end
      return array.flatten
    end

    def preferred_vendor(date=nil) # date is option, defaults to nil
      if date
        newsales_ar = vendor_daily_revenue(date)
        prefvendor = newsales_ar.max_by {|array| array[1]}
        catch_duplicates(prefvendor, newsales_ar)
      else
        vendors.max_by { |m| m.revenue}
      end
    end

    def worst_vendor(date=nil) # date is option, defaults to nil
      if date
        newsales_ar = vendor_daily_revenue(date)
        worstvendor = newsales_ar.min_by {|array| array[1]}
        catch_duplicates(worstvendor, newsales_ar)
      else
        vendors.min_by { |m| m.revenue}
      end
    end

    def vendor_daily_revenue(date)
      newsales_ar = []
      vendors.each do |vendor|
        newsales_ar << [vendor, vendor.revenue(date)]
      end
      return newsales_ar
    end

    def catch_duplicates(minmaxvendor, newsales_ar)
      duplicates = newsales_ar.find_all { |sale| sale[1] == minmaxvendor[1]}
      if duplicates.length > 1
        duplicate_vendors = []
        duplicates.each { |vendor| duplicate_vendors << vendor[0] }
        return duplicate_vendors
      else
        minmaxvendor[0]
      end
    end
  end
end
