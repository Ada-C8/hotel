require 'date'
require_relative 'room'
require_relative 'reservable'

module Hotel

  class Reservation
    include Comparable
    include Reservable

    @@all_reservations = []

    attr_accessor :check_in, :check_out, :room_num, :rate, :reservation_id

    def initialize(check_in, check_out, room)

      valid_dates?(check_in, check_out)
      valid_room?(room)

      @reservation_id = @@all_reservations.length + 1
      @check_in = check_in
      @check_out = check_out
      @room_num = room.room_num
      @rate = room.rate

      @@all_reservations << self
    end

    def ==(other_reservation)
      return check_in == other_reservation.check_in && check_out == other_reservation.check_out && room_num == other_reservation.room_num
    end

    # def include?(date)
    #   return date >= check_in && date < check_out
    # end

    def total_cost
      num_nights = (check_out - check_in).to_i
      # return num_nights * ::Hotel::Room::DEFAULT_RATE
      return num_nights * rate
    end

    def self.all
      return @@all_reservations
    end

    def self.find(reservation_id)
      reservations = self.all

      reservations.each do |reservation|
        if reservation.reservation_id == reservation_id
          return reservation
        end
      end

      return nil
    end

    def self.clear
      # clears all reservations (for testing)
      @@all_reservations = []
    end


    def to_s
      # return human readable representation
      s = "Reservation id: #{reservation_id}\n"
      s += "Room number: #{room_num}\n"
      s += "Check-in: #{check_in}\n"
      s += "Check-out: #{check_out}\n"

      return s

    end

  end # end of Reservation class
end
