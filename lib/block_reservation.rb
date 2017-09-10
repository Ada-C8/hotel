require 'pry'
module Hotel
  #TODO: Make overlap? a mixin and add it into block_reservation and reservation
  class BlockReservation
    attr_reader :check_in, :check_out, :reservations, :rate
    #initialize
    #initialize would now take in check_in, check_out, and an Array of Room objects
    def initialize(check_in, check_out, rooms)
      raise ArgumentError.new("There's only one room in the rooms parameter. Try creating a regular reservation instead") if rooms.length <= 1
      raise ArgumentError.new("You can only have a maximum of 5 rooms in a block.") if rooms.length > 6
      @check_in = check_in
      @check_out = check_out
      @reservations = make_reservations(rooms)
      # Rates: 2 rooms = 10% off, 3 = 15%, 4 = 20%, 5 = 25% (Max of 5 rooms per block)
      @rate = (0.05 * rooms.length).round(2)
    end

    def make_reservations(rooms)
      block_reservations = []
      rooms.each do |room|
         block_reservations << Hotel::Reservation.new(check_in, check_out, room)
      end
      return block_reservations
    end

    def total_cost
      cost = 0
      @reservations.each do |reservation|
        if reservation.room.available
          cost += reservation.room.cost
        end
      end
      total_days = (check_out - check_in).to_i
      cost *= total_days
      return (cost - (cost * @rate)).to_i
    end

    # TODO: REFACTOR, this is redundant w/ Reservation class
    # (check_in >= reservation.check_in || check_out < reservation.check_out) && room_num == reservation.room.room_number
    def overlap?(other_check_in, other_check_out)
      # return (check_in >= other_check_in || check_out < other_check_out) &&
      #        room.room_number == other_room_num
      return (other_check_in == check_in ||
             (other_check_in < check_in && (other_check_out > check_in && other_check_out < check_out)) ||
             (other_check_in > check_in && other_check_in < check_out))
    end

  end
end
