require 'date'
require 'rooms'

module Hotels
  class Hotel

    def initialize(start_date, end_date)
      @start_date = start_date
      @end_date = end_date
    end

    def date_range(start_date, end_date)
      start_date = Date.new(start_date)
      end_date = Date.new(end_date)
    end 


    def make_rooms
      rooms = []
      date_range = []
      number = 0
      20.times do
        number += 1
        rooms << Hotels::Rooms.new(number, date_range)
      end
      return rooms
    end

    def find_room
      i = 0
      rooms.each do |room|
        if rooms[i].date_range.include? date_range

        end

      end
    end


  end
end
