require_relative 'date_range'
require_relative 'reservation'
require_relative 'hotel'

module Hotel

  class BlockRoom<Reservation

    attr_reader :check_in, :check_out, :num_of_rooms, :discount, :block_of_rooms

    attr_accessor :available_rooms, :booked_rooms

    ## just creating a block of rooms that have not been booked yet##
    def initialize(check_in, check_out, num_of_rooms = 5, client = nil, discount = 15, cost = 200)

      super(check_in, check_out, cost)
      @discount = discount
      @reservation_array << @discount

      @num_of_rooms = num_of_rooms
      @reservation_array << @num_of_rooms

      @block_of_rooms = []
      @reservation_array << block_of_rooms

      @available_rooms = @block_of_rooms
      @reservation_array << @available_rooms

      @booked_rooms = []
      @reservation_array << @booked_rooms


    end #initialize

    def check_if_block_has_available_rooms
      if @available_rooms.length >= 1
        return true
      else
        return raise ArgumentError.new("It appears there are no available rooms in block")
      end
    end

  end #class
end#module
