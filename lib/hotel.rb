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
      @all_reservations.each do |reservation|
        if reservation.room == room
          reservation.date_range.dates_within_range.each do |date|
            dates << date
          end
        end
      end
      return dates #array of dates on which this room is unavailable
    end #end of method

    def find_room(date_range)
      # puts "Checking #{date_range}, #{date_range.dates_within_range}"
      available_room = nil
      @rooms.each_with_index do |room, i|
        booked_dates = room_unavailable(i + 1) #array of dates
        # puts "Room #{room} unavailable dates #{booked_dates}"

        count = 0
        date_range.dates_within_range.each do |date|
          if !booked_dates.include?(date)
            count += 1
          end
        end
        if count == date_range.dates_within_range.length
          available_room = room
          break
        end

        # if !booked_dates.include?(date_range.dates_within_range)
        #   available_room = room
        #   puts room
        #   break
        # end
      end
      return available_room #room number
    end #end of method

    def make_reservation(date_range)
      room = find_room(date_range)
      if room == nil
        raise ArgumentError.new("No room is available on given dates")
      end
      if room != nil
        new_reservation = Reservation.new(date_range, room)
        @all_reservations << new_reservation
      end
      return new_reservation #new instance of class Reservation
    end #end of method

  end #end of class

end #end of module
