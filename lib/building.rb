require_relative 'room'

module Hotel

  class Building
    attr_accessor :rooms

    def initialize
      @rooms = [] #NOTE As an administrator, I can access the list of all the rooms in the hotel"

      20.times do |num|
        @rooms << Hotel::Room.new(num + 1)
      end
    end

    def self.search_date(date)
      list = []

      @rooms.each do |room|
        #if room.dates_reserved.includes date, add reservation object to the list
        @rooms[room].reservations.each do |res, dates|
          if dates.includes?(date)
            list << res
          end
        end
      end

      return list
    end

  end # Building class

end # Hotel module
