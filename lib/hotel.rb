require 'date'
require_relative 'room'
require_relative 'reservation'

module Hotel

  class California
    attr_reader :rooms, :reservations

    def initialize
      @num_of_rooms = 20
      @rate = 200
      @rooms = {}
      (1..@num_of_rooms).each do |room|
        @rooms[room] = Hotel::Room.new(room, @rate)
      end
      @reservations = []
    end

    def create_reservation(start_date, end_date)
      start_date = Date.parse(start_date)
      end_date = Date.parse(end_date)
      @reservations << Hotel::Reservation.new(start_date, end_date)
    end

    # ~ num of nights (days - 1) * per night
    def reservation_total
    end

    # find all reservations for a date
    def self.find_by_date(year,month,day)
    end

    def all_rooms
    end

    def all_reservations
    end

  end #end of California
end #end of Hotel
