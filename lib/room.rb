module Hotel
  class Room
    attr_reader :price, :name

    def initialize(name, price)
      @name = name.capitalize
      @price = price.to_f
    end

  end
end
