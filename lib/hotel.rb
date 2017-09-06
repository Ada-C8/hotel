module My_Hotel
  class Hotel

    attr_reader :list_of_rooms, :list_of_reservations

    def initialize
      @list_of_rooms = make_rooms
      @list_of_reservations = Reservation.all
    end


    # def make_rooms
    #   room_number_array = [1..20]
    #   20.times do
    #     index = 0
    #     Reservation.new(room_number_array, 200)
    #     index +=1
    #   end
    # end

# def get_reservations
# end

    # def display_rooms
    #   #puts out list of rooms
    # end

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
