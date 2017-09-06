module Hotel

  class Room
    #attr
    attr_reader :number, :rate, :dates_reserved, :check_in, :check_out, :reservation

    #constants
    #TODO 2. decide on ROOM_RATE constant?

    #initialize
    def initialize(number)
      @number = number
      @rate = 200
      @dates_reserved = Array.new
    end
    #class methods

    #instance methods
    def reserve(check_in, nights)

      nights.times do |date|
        @dates_reserved << Date.parse(check_in) + date
      end

      @reservation = Hotel::Reservation.new(check_in, nights, self)

    end

  end # Room class

end # Hotel module
