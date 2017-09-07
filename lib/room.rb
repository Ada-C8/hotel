module ReservationSystem

  class Room
    #     #attr
    #     attr_reader :number, :rate, :dates_reserved, :check_in, :check_out, :reservations, :reservation
    #
    #     #constants
    #     #TODO 2. decide on ROOM_RATE constant?
    #
    #     #initialize
    #     def initialize(number)
    #       @number = number
    #       @rate = 200
    #       @dates_reserved = Array.new
    #       @reservations = Array.new
    #     end
    #     #class methods
    #
    #     #instance methods
        # def reserve(check_in, nights)
        #
        #   nights.times do |day|
        #     @dates_reserved << Date.parse(check_in) + day
        #   end
        #
        #   @reservation = Hotel::Reservation.new(check_in, nights, self)
        #   # @reservations << @reservation
        #   @reservations << {@reservation => @dates_reserved}
        #
        # end

    #   end # Room class
    #
    # end # Hotel module

    #============== OLD WORK ====================#
    attr_reader :number, :rate, :nights_reserved

    def initialize(number)
      @number = number
      @rate = 200 #TODO decide: could be a constant?
      @nights_reserved = Array.new
    end

  end #class Room
end #ReservationSystem module
