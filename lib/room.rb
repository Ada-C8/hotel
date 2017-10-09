module Hotel
  class Room
    attr_reader :number, :cost

    def initialize(number)
      @number = number
      @cost = 200
    end

  end
end
