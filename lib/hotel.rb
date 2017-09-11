require 'pry'
require 'date'
require_relative 'reservation'
require_relative 'reservation_list'
require_relative 'date_range'
require_relative 'block'

module Hotel
  class Hotel

    attr_reader :all_rooms, :reservations, :block

    def initialize
      @block = Block.new
      @reservations = ReservationList.new
      @all_rooms = {1 => 200, 2 => 200, 3 => 200, 4 => 200, 5 => 200, 6 => 200, 7 => 200, 8 => 200, 9 => 200, 10 => 200, 11 => 200, 12 => 200, 13 => 200, 14 => 200, 15 => 200, 16 => 200, 17 => 200, 18 => 200, 19 => 200, 20 => 200}
    end

    def make_reservation(id, day_in, day_out, discount: 0, block_name: nil, room: 0)
      available = open_rooms(day_in, day_out)
      if room == 0
        first_open = available[0]
      elsif room != 0 && available.include?(room)
        first_open = room
      else
        raise ArgumentError, "Requested Room is Not Available during Date Range"
      end
      @reservations.add(id, day_in, day_out, discount, block_name, room: first_open)
    end

    def find_reservations(day_in, day_out)
      all_reservations = @reservations.reservation_list + @block.block_list
      found_reservations = Array.new
      DateRange.check_dates(day_in, day_out)
      DateRange.create_range(day_in, day_out).each do |date|
        found_reservations << all_reservations.find_all { |reservation| reservation.nights_reserved.include?(Date.parse(date)) }
      end #each date
      return found_reservations.flatten.uniq
    end #find_reservations

    def total_cost(reservation_id)
      @reservations.reservation_list.each do |reservation|
        if reservation.id == reservation_id
          return reservation.total_cost
        else
          return "Reservation Not Found"
        end #end if
      end #end each
    end #end total cost

    def open_rooms(day_in, day_out)
      occupied_rooms = Array.new
      find_reservations(day_in, day_out).each do |reservation|
        occupied_rooms << reservation.room
      end
      open_rooms = (@all_rooms.keys - occupied_rooms)
      return open_rooms
    end

    def create_block(id, day_in, day_out, discount: 0, number_of_rooms: 1, block_name: nil)
      if number_of_rooms > 5
        return "A block cannot have more than 5 rooms"
      end
      available = open_rooms(day_in, day_out)
      if available.length >= number_of_rooms
        available.take(number_of_rooms).each do |room_number|
          @block.add(id, day_in, day_out, discount, block_name, room: room_number)
        end#each
      else
        raise ArgumentError, "Not Enough Rooms Available to Form Block"
      end
    end

    def reserve_in_block(block_name)
      room = @block.block_list.find { |reservation| block_name.include?(block_name.upcase)}
      @reservations.reservation_list << room
      @block.block_list.delete(room)
    end
  end #class
end #module

# @boetel = Hotel::Hotel.new
# @boetel.make_reservation(1201, "2017/12/12", "2017/12/14")
# @boetel.create_block(1545, "2017/12/12", "2017/12/14", discount: 50, number_of_rooms: 2, block_name: "HELD")
# @boetel.reserve_in_block("HELD")
#
#
# binding.pry


# @hotel = Hotel::Hotel.new
#make_reservation(id, day_in, day_out, discount: 0, number_of_rooms: 1, room: 0, block_name: nil)
# @hotel.make_reservation(2222, "2012/12/12", "2012/12/15", room: 2)
# @hotel.make_reservation(2224, "2012/12/13", "2012/12/17", room: 10)
# x = @hotel.open_rooms("2012/12/12", "2012/12/13")
# #@hotel.open_rooms("2012/12/12", "2012/12/13")[0].must_equal 1

# @boetel.make_reservation(1202, "2017/12/10", "2017/12/12", room: 10)
# @boetel.make_reservation(1203, "2017/12/12", "2017/12/15", block_name: 1289)
# @boetel.make_reservation(1204, "2017/12/14", "2017/12/16")

# @boetel.find_reservations("2017/12/14", "2017/12/15")
# open = @boetel.open_rooms("2017/12/12", "2017/12/14")

        # found_reservations << @reservations.reservation_list.find_all { |reservation| reservation.nights_reserved.include?(Date.parse(date)) }
