module Hotel
  class Room
    attr_reader :price, :number
    attr_accessor :booked

    def initialize(number, price = 200)
      @number = number.to_i
      @price = price.to_f
      @booked = []
    end

  end
end
