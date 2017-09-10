require_relative 'date_range'
require_relative 'reservation'
require_relative 'hotel'

module Hotel

  class BlockRoom<Reservation

    attr_reader :check_in, :check_out, :num_of_rooms, :discount, :collection_of_rooms

    ## just creating a block of rooms that have not been booked yet##
    def initialize(check_in, check_out, num_of_rooms = 5, client = nil, discount = 15, cost = 200)

      super(check_in, check_out, cost)
      @discount = discount
      @reservation_array << @discount

      @num_of_rooms = num_of_rooms
      @reservation_array << @num_of_rooms

      @collection_of_rooms = []

      # @rooms_in_block = []
      # @status_of_rooms = nil

      # if rooms_in_block.length > 0




      # if Reservation.room_availability(check_in, check_out).length >= num_of_rooms
      #   @rooms_in_block << room_availability(check_in, check_out).pop(num_of_rooms)
      #   @status_of_rooms = Array.new(num_of_rooms, nil)
      # else
      #   return raise ArgumentError.new("There are not enough rooms available for that date")
      # end


      # @status = status
      # @reservation_array << @status

      # #####NOTE##### Trying to create hash of rooms in block based on their availability####
      #         @rooms_status = rooms_in_block.zip(@status_of_rooms)
      #
      # ###or###
      #         rooms_availability_in_block_hash = {}
      #         @rooms_in_block.each_with_index {|key, index| rooms_availability_in_block_hash[key] = @status_of_rooms[index]}
      # hash = {}
      # keys.each_with_index { |key, index| hash[key] = values[index] }
    end #initialize

    def check_if_block_has_available_rooms
    end

    # ability to reserve a room within a block of rooms
    #needs to match the date range of the block
    def reserve_room_in_block_based_on_date(check_in, check_out, num_of_rooms)
      #need to confirm there is availability
      #need to match the range in the block
    end

    #not a requirement, but could be a nice way to search for something
    def reserve_room_in_block_based_on_client(check_in, check_out, client)
    end


  end #class
end#module
