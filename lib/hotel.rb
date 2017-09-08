require_relative 'reservable'
require_relative 'room'

module ReservationSystem
  #TODO END OF ASSIGNMENT Go through each file and auto indent"
  class Hotel
    include Reservable

    attr_accessor :hotel, :all_reservations, :new_reservation

    def initialize
      @hotel = Array.new
      @all_reservations = Array.new

      20.times do |num|
        @hotel << ReservationSystem::Room.new(num + 1)
      end
    end # initialize

    def reserve(check_in, nights, room)
      valid_date?(check_in)
      positive_integer?(nights)
      if room.available?(check_in, nights)
        @new_reservation = ReservationSystem::Reservation.new(check_in, nights, room)
        all_reservations << @new_reservation
        return @new_reservation
      else
        raise UnavailableDate.new("This room is unavailable for #{nights} night(s) starting on #{check_in}")
      end

    end # reserve

    def search_reservations_by_date(date)
      valid_date?(date)
      list = Array.new

      all_reservations.each do |res|
        list << res if res.dates_reserved.include?(date)
      end

      return list
    end # search_reservations_by_date

    def search_available_rooms_by_dates(start, nights)
      rooms = hotel.dup
      date_array = date_range(start, nights)

      date_array.each do |date|
        rooms.delete_if { |room| room.nights_reserved.include?(date) }
      end

      return rooms
    end # "search_available_rooms_by_dates"

  end #Hotel class

end #ReservationSystem module
