module ReservationSystem

  class Room
    attr_reader :number, :rate, :nights_reserved

    def initialize(number)
      @number = number
      @rate = 200 #TODO decide: could be a constant?
      @nights_reserved = Array.new
    end

  end #class Room
end #ReservationSystem module
