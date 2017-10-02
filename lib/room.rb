module Hotel
  class Room
    attr_reader :number, :rate

    def initialize(number, rate)
      @number = number
      @rate = rate
    end
  end
end
