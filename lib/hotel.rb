require_relative 'reservation'
require_relative 'date_range'

module BookingSystem
  class Hotel

    attr_reader :rooms, :all_reservations

    def initialize(number_of_rooms)
      @rooms = (1 .. number_of_rooms).to_a
      @all_reservations = [] #array of instances of class Reservation
    end #end of initialize

    def room_unavailable(room)
      dates = []
      all_reservations.each do |reservation|
        if reservation.room == room
          reservation.date_range.dates_within_range.each do |date|
            dates << date
          end
        end
      end
      return dates #array of dates on which this room is unavailable
    end #end of method

    # def make_reservation(date_range)
    #   @all_reservations.each do |reservation|
    #     if
    #   end
    #
    # end #end of method

  end #end of class

end #end of module
