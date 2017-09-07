require_relative 'reservation'
module My_Hotel
  class Hotel
    ROOMS = {1 => 200,
      2 => 200,
      3 => 200,
      4 => 200,
      5 => 200,
      6 => 200,
      7 => 200,
      8 => 200,
      9 => 200,
      10 => 200,
      11 => 200,
      12 => 200,
      13 => 200,
      14 => 200,
      15 => 200,
      16 => 200,
      17 => 200,
      18 => 200,
      19 => 200,
      20 => 200
    }

    attr_reader :rooms, :all_reservations

    def initialize
      @rooms = ROOMS
      @all_reservations = []
    end

    def display_rooms
      index = 1
      rooms.each do |room, price|
        puts "Room Number #{index}: $#{price} per night."
        index += 1
      end
    end

    def make_reservation(first_night, last_night)
      new_reservation = My_Hotel::Reservation.new(first_night, last_night)
      @all_reservations << new_reservation
      assign_room(new_reservation)
      set_cost(new_reservation)
      set_reservation_id(new_reservation)
      return new_reservation
    end

    def set_cost(reservation)
      if reservation.nights_booked.nights.to_a.length <= 0
        return reservation.cost = 0
      else
        number_of_nights = reservation.nights_booked.nights.to_a.length
        cost_per_night = ROOMS[reservation.room_number]
        cost = number_of_nights * cost_per_night
        reservation.cost = cost
      end
    end

    def set_reservation_id(reservation)
      reservation.reservation_id = @all_reservations.length if @all_reservations != []
    end

    def assign_room(reservation)
      rooms_available = find_unreserved_rooms(reservation.first_night..reservation.last_night)
      room_number = rooms_available.keys.sample
      # room_number = rand(20) + 1
      reservation.room_number = room_number
    end

    #given the reservation_id, returns the reservation if it exists, or nill if it does not
    def find_by_reservation_id(reservation_id)
      @all_reservations.each do |reservation|
        if reservation.reservation_id == reservation_id
          return reservation
        end
      end
      return nil
    end

    #given a range of nights, it will find rooms that are available for every night in the range.
    #if no room is available for the whole range, returns an empty hash
    def find_unreserved_rooms(nights)
      array_of_rooms = []
      nights.each do |night|
        reservations_on_date = find_reservations_by_date(night)
        free_rooms = ROOMS.dup
        reservations_on_date.each do |reservation|
          free_rooms.delete(reservation.room_number)
        end
        array_of_rooms << free_rooms
      end

      free_for_range = {}
      array_of_rooms[0].each do |room, cost|
        free = true
        array_of_rooms.each do |free_rooms|
          free = free && (free_rooms[room] != nil)
        end
        if free == true
          free_for_range[room] = cost
        end
      end
      return free_for_range
    end

    #given an array [year,month,day], it returns all the reservations on that day.
    #if there are no reservations on that day, returns an empty array
    def find_reservations_by_date(date)
      reservations_on_date = []
      @all_reservations.each do |reservation|
        if reservation.nights_booked.nights.include?(date)
          reservations_on_date << reservation
        end
      end
      return reservations_on_date
    end



    # if @list_of_reservations.length  == 0 #if there are no reservations make any random reservation_id
    #   return 5.times do reservation_id << rand(9)
    #   end
    # end
    #
    # unique = false
    # while unique == false #while reservation_id is not unique
    #   unique = true
    #   5.times do reservation_id << rand(9) #make new reservation_id
    #     @list_of_reservations.each do |reservation| #check if unique
    #       if reservation.reservation_id == reservation_id
    #         unique = false
    #       end
    #     end
    #   end
    # end
    # reservation_id

    #def make_block
    #define a block
    # make a random_id_number for block.
    #end

    #def rooms_available_block(block_id)
    #shows if any rooms in the block are available
    # end

  end
end

# #
# hotel_california= My_Hotel::Hotel.new
# first_night = Date.civil(2017,2,1)
# last_night = Date.civil(2017,2,5)
# a = hotel_california.make_reservation(first_night, last_night)
# first_night = Date.civil(2017,2,3)
# last_night = Date.civil(2017,5,6)
# b = hotel_california.make_reservation(first_night,last_night)
# first_night = Date.civil(2017,4,3)
# last_night = Date.civil(2017,4,6)
# c = hotel_california.make_reservation(first_night, last_night)
#
# #
# f = Date.civil(2017,2,4)
# j = Date.civil(2017,2,5)
# g = Date.civil(2017,2,6)
#  puts a.room_number
#  puts b.room_number
# # puts e.room_number
# # puts d.room_number
#  puts hotel_california.find_reservations_by_date(j).class
#  puts hj= hotel_california.find_unreserved_rooms(f..g)
# # q = hotel_california.make_reservation(arrive,leave)
# # puts q.room_number
# # puts hj= hotel_california.find_unreserved_rooms(f..g)
# # puts h.find_reservations_by_date([2017,2,3])
