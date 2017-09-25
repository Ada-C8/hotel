#Notes for how Block will be used in Booking
  #make_block method
    #will make a new instance of a block.
    #It will have a date range, a block ID (that is a sting.upcase), and the number of rooms in the block (maximum of five!).
    #Will check that there are enough availible rooms before making the block.
    #Will add the new instance of Block to the @all_blocks array in Booking.
    #Will only allow unique block_id's to be entered
  # check_block_availibility
      # will check how many rooms are left in the block by iterating though the @all_blocks array to find the block with the right block_id
  # reserve_block_room
      # will reserve a room from within a block
      # it will find the block from within the @all_block array using a block_id
      # First it will check that there are still enough rooms within the block before making the reservation
      # Then it will make a reservation (with a discounted price) and add this reservation to the @all_reservations array.
      # It will delete the room from the block once there is a reservation for that room.


module Hotel
  class Block
    attr_reader :block_id, :block_rooms, :date_range
    def initialize(block_id, block_rooms, date_range)
      @block_id = block_id.upcase
      @block_rooms = block_rooms
      @date_range = date_range
    end # initialize

    def reserve_room(reservation_id, num_of_rooms)
      # reservation_id will be passed in as an argument from the reserve_from_block method in Bookings
      reserved_rooms_from_block = []

      #Adds all rooms from @block_rooms to rooms array
      rooms = []
      i = 0
      num_of_rooms.times do
        rooms << @block_rooms[i] 
        i += 1
      end # .each

      #deletes all the rooms in the rooms array from @block_rooms
      rooms.each do |room|
        @block_rooms.delete(room)
      end # .each

      cost = (num_of_rooms * @date_range.length * 180.0)

      reserved_rooms_from_block << Hotel::Reservation.new(reservation_id, cost, rooms, @date_range)

    end # reserve_room
  end # Block
end # Hotel

# def make_reservation(start_date, end_date, num_rooms )
#   if end_date < start_date
#     raise BookingError.new("Your checkout day must be after your checkin date! You entered: checkin day = #{start_date} and checkout date = #{end_date}")
#   else
#     availible = availible_rooms(start_date, end_date)
#     if num_rooms > 20
#       raise BookingError.new("You can't book that many rooms because we only have 20 rooms in the hotel.")
#     elsif num_rooms > availible.length
#       raise BookingError.new("We don't have that many rooms availible for those dates. We only have #{availible.length} rooms availible for those dates. ")
#     end # if/elsif
#
#     dates_booked = Hotel::DateRange.new(start_date, end_date).nights_booked
#     reservation_id = @all_reservations.length + 1
#     rooms = []
#     i = 0
#     num_rooms.times do
#       rooms << availible[i]
#       i += 1
#       # availible = availible_rooms(start_date, end_date)
#     end
#     cost = (num_rooms * dates_booked.length * 200.0)
#
#     @all_reservations << Hotel::Reservation.new(reservation_id, cost, rooms, dates_booked)
#
#   end # if/else
# end # make_reservation
