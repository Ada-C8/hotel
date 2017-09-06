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

    def make_reservation(arrive, leave)
      new_reservation = My_Hotel::Reservation.new(arrive, leave)
      @all_reservations << new_reservation
      assign_room(new_reservation)
      set_cost(new_reservation)
      set_reservation_id(new_reservation)
      return new_reservation
    end

    def set_cost(reservation)
      if reservation.nights.to_a.length <= 0
        return reservation.cost = 0
      else
        number_of_nights = reservation.nights.to_a.length
        cost_per_night = ROOMS[reservation.room_number]
        cost = number_of_nights * cost_per_night
        reservation.cost = cost
      end
    end

    def set_reservation_id(reservation)
      reservation.reservation_id = @all_reservations.length if @all_reservations != []
    end

    def assign_room(reservation)
      room_number = rand(20) + 1
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

    def find_reserved_rooms(date)
      reservations_on_date = find_reservations_by_date(date)
      booked_rooms = []
      reservations_on_date.each do |reservation|
        booked_rooms << reservation.room_number
      end
      return booked_rooms
    end


    #given an array [year,month,day], it returns all the reservations on that day.
    #if there are no reservations on that day, returns an empty array
    def find_reservations_by_date(date)
      # check_date = Date.civil(date[0], date[1], date[2])
      reservations_on_date = []
      @all_reservations.each do |reservation|
        if reservation.nights.include?(date)
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

#
# h= My_Hotel::Hotel.new
# a = h.make_reservation([2017,2,1],[2017,2,5])
# b = h.make_reservation([2017,2,3],[2017,2,6])
# c = h.make_reservation([2017,4,3],[2017,4,6])
# puts a.room_number
# puts b.room_number
# puts c.room_number
# puts h.find_reserved_rooms([2017,2,3])
# # puts
# puts h.find_reservations_by_date([2017,2,3])
