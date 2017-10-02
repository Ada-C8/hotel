module Hotel
  class Room
    attr_reader :number, :cost
    attr_accessor :reserved

    def initialize(number, reserved: nil)
      @number = number
      @cost = 200
      @reserved = reserved
    end
  end
end
