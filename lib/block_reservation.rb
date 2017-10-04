require 'pry'
module Hotel
  #TODO: Make overlap? a mixin and add it into block_reservation and reservation
  class BlockReservation
    attr_reader :check_in, :check_out, :reservations, :rate, :rooms
    #initialize
    #initialize would now take in check_in, check_out, and an Array of Room objects
    def initialize(check_in, check_out, rooms)
      raise ArgumentError.new("There's only one room in the rooms parameter. Try creating a regular reservation instead") if rooms.length <= 1
      raise ArgumentError.new("You can only have a maximum of 5 rooms in a block.") if rooms.length >= 6
      @check_in = check_in
      @check_out = check_out
      @rooms = rooms
      @reservations = []
      # Rates: 2 rooms = 10% off, 3 = 15%, 4 = 20%, 5 = 25% (Max of 5 rooms per block)
      @rate = (0.05 * rooms.length).round(2)
    end


    def total_cost
      cost = 0
      @reservations.each do |reservation|
        cost += reservation.room.cost
      end
      total_days = (check_out - check_in).to_i
      cost *= total_days
      return (cost - (cost * @rate)).to_i
    end

    def rooms_available
      available_rooms = @rooms
      reserved_rooms = @reservations.map{|reservation| reservation.room}
      available_rooms.keep_if do |room|
        !reserved_rooms.include?(room)
      end
      return available_rooms
    end

    # Make the reservation for each room passed into the room list
    def make_reservation(room_number, admin)
      room_numbers = @rooms.map{|room| room.room_number}
      raise ArgumentError.new("Room Number not included in block") if !room_numbers.include?(room_number)
      @reservations.each do |reservation|
        raise ArgumentError.new("Reservation for room #{room_number} already exists") if reservation.room.room_number == room_number
      end

      @rooms.each do |room|
        if room.room_number == room_number
          room.set_booked_dates(admin)
          @reservations << Hotel::Reservation.new(@check_in, @check_out, room)
        end
      end
    end

    # TODO: REFACTOR, this is redundant w/ Reservation class
    def overlap?(other_check_in, other_check_out)
      return (other_check_in == check_in ||
             (other_check_in < check_in && (other_check_out > check_in && other_check_out < check_out)) ||
             (other_check_in > check_in && other_check_in < check_out))
    end

  end
end
