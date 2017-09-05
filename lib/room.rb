module Hotel
  class Room
    attr_reader :price, :name

    def initialize(name, price)
      @name = name.gsub(/[A-Za-z']+/,&:capitalize)
      @price = price.to_f
    end

  end
end
