require 'date'
require 'rooms'

module Hotels
  class Hotel
     attr_reader :rooms, :reservations
    def initialize
      @rooms = make_rooms
      @reservations = []
    end
#check to make sure in future, end_date is after start_date
    def check_dates(start_date, end_date)
      date_array = []
      if Date.valid_date?(start_date[0], start_date[1], start_date[2]) && Date.valid_date?(end_date[0], end_date[1], end_date[2])
      start_date = Date.new(start_date[0], start_date[1], start_date[2])
      end_date = Date.new(end_date[0], end_date[1], end_date[2])
        if (start_date < end_date) && (start_date == Date.today || ((start_date > Date.today)))
          date_array << start_date
          date_array << end_date
        else
          raise ArgumentError.new("Invalid dates.")
        end
      else
        raise ArgumentError.new("Invalid dates.")
      return date_array
      end
    end

    def make_rooms
      rooms = Hotels::Rooms.all
      return rooms
    end

    def date_range(date_array)
      date_range = []
      until date_array[0] == date_array[1]
        date_range << date_array[0]
          date_array[0] += 1
      end
        return date_range
    end


    def list_booked_rooms(date_range)
      booked_rooms = []
      date_range.each do |date|
       @reservations.each do |one_res|
         if one_res.date_range.include? date
            booked_rooms << one_res.room
         end
       end
      end
      return booked_rooms
    end

    def list_unbooked_rooms(list_booked_rooms)
      unbooked_rooms = []
    @rooms.each do |room|
      if list_booked_rooms.include? room
      else
        unbooked_rooms << room
      end
    end
    return unbooked_rooms
    end



    def find_room(list_unbooked_rooms)
      if list_unbooked_rooms.length == 0
        raise ArgumentError.new("Hotel is booked.")
      else
      room = list_unbooked_rooms.sample
      return room
      end 
    end

    def make_reservation(find_room, date_range)
      @reservations << Hotels::Reservations.new(find_room, date_range)
      return @reservations
    end



  end
end
