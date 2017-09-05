require 'date'
require 'rooms'

module Hotel
  class reservations
    attr_reader :room, :dates, :cost
    def initialize(room, dates, cost)
      @room = room
      @dates = Date.new(dates)
    end

    def check_dates(dates)
      #conditional with regex to check valid dates
      #.valid_date?
      #date conversion with gem?
    end

  end
end
