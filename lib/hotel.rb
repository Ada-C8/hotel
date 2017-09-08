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
      date_array << start_date
      date_array << end_date
      else
      raise ArgumentError.new("Invalid dates.")
      end
      return date_array
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
         if one_res.dates.include? date
            booked_rooms << one_res.room
         end
       end
      end
      return booked_rooms
    end



    def find_room
      rooms.each do |room|
        if room.date_range.include? date_range
        else
          return room
        end
      end

    end


  end
end
