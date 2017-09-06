module Hotel
  class Room
    attr_reader :price, :number

    def initialize(number, price = 200)
      @number = number.to_i
      @price = price.to_f
      # @status =
    end

  end
end
