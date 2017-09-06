require_relative 'reservation'
module My_Hotel
  class Hotel
    ROOMS = {room_1: 200,
      room_2: 200,
      room_3: 200,
      room_4: 200,
      room_5: 200,
      room_6: 200,
      room_7: 200,
      room_8: 200,
      room_9: 200,
      room_10: 200,
      room_11: 200,
      room_12: 200,
      room_13: 200,
      room_14: 200,
      room_15: 200,
      room_16: 200,
      room_17: 200,
      room_18: 200,
      room_19: 200,
      room_20: 200
    }


    attr_reader :rooms, :list_of_reservations

    def initialize
      @rooms = ROOMS
      @list_of_reservations = []
    end



    # def make_rooms
    #   room_number_array = [1..20]
    #   20.times do
    #     index = 0
    #     Reservation.new(room_number_array, 200)
    #     index +=1
    #   end
    # end


    def display_rooms
      index = 1
      rooms.each do |room, price|
        puts "Room Number #{index}: $#{price} per night."
        index += 1
      end

      # def display_reservations
      #   #puts out list of reservations
      # end

      #     def rooms_available_date(start_date, end_date)
      # #display rooms available on that date
      #     end

      #def make_block
      #define a block
      # make a random_id_number for block.
      #end

      #def rooms_available_block(block_id)
      #shows if any rooms in the block are available
      # end

    end
  end
end
# h= My_Hotel::Hotel.new
# h.display_rooms
