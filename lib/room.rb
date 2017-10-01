require_relative 'reservation'
require_relative 'reservable'

module Hotel

  class Room
    include Reservable
    include Comparable

    @@all_rooms = []

    DEFAULT_RATE = 200

    attr_reader :room_num, :reservations, :blocks
    attr_accessor :rate

    def initialize(room_num, rate = DEFAULT_RATE)

      check_room_num(room_num)
      check_rate(rate)

      @room_num = room_num
      @reservations = []
      @blocks = []
      @rate = rate

      @@all_rooms << self

    end

    def <=>(other_room)
      room_num <=> other_room.room_num
    end

    def reserve(start_date, end_date, rate_to_charge = rate)

      raise ArgumentError.new("Room #{room_num} isn't available for the given dates") if booked?(start_date, end_date)

      new_reservation = ::Hotel::Reservation.new(start_date, end_date, self, rate_to_charge)
      reservations << new_reservation#.reservation_id

      return new_reservation

    end

    def booked?(start_date, end_date = start_date.next_day)

      return includes_date?(reservations, start_date, end_date)

    end

    def blocked?(start_date, end_date = start_date.next_day)

      return includes_date?(blocks, start_date, end_date)

    end

    def self.all
      # @all_rooms.sort!
      return @@all_rooms
    end

    def self.find(room_num)
      rooms = self.all

      rooms.each do |room|
        if room.room_num == room_num
          return room
        end
      end

      return nil
    end

    def self.clear
      @@all_rooms = []
    end

    def to_s
      # return human readable representation
      s = "Room number: #{room_num}\n"
      s += "Rate per night: $#{rate}\n"
      s += "Reservations:\n"

      reservations.each do |reservation|
        s += reservation.to_s
      end

      # s += "Blocks:\n"
      # blocks.each do |block|
      #   s += block.to_s
      # end

      return (s += "\n")

    end

    private

    def includes_date?(blocks_or_res_array, start_date, end_date)
      # don't include final date since check-out doesn't conflict with check-in of a new reservation
      date_range = (start_date...end_date).to_a

      blocks_or_res_array.each do |item|
        date_range.each do |date|
          if item.include?(date)
            return true
          end
        end
      end

      return false
    end

  end # end of Room class

end
