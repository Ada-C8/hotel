require 'date'
require 'rooms'

module Hotels
  class Reservations
    attr_reader :room, :dates, :cost
    def initialize(start_date, end_date)
      @room = room
      @start_date = start_date
      @end_date = end_date
    end

    def check_dates(dates)
      #conditional with regex to check valid dates
      #.valid_date?
      #date conversion with gem?
    end

    def gets_room
      @room = Hotels::Rooms.find(1..20).sample
    end

    def calculate_bill
    end



  end
end
