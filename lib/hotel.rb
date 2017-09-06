require 'date'
require_relative 'room'
require_relative 'reservation'

module Hotel

  class California
    attr_reader :all_rooms, :all_reservations

    def initialize
      @num_of_rooms = 20
      @rate = 200
      @all_rooms = {}
      (1..@num_of_rooms).each do |room|
        @all_rooms[room] = Hotel::Room.new(room, @rate)
      end
      @all_reservations = []
    end

    def create_reservation(start_date, end_date)
      start_date = Date.parse(start_date)
      end_date = Date.parse(end_date)
      @all_reservations << Hotel::Reservation.new(start_date, end_date)
    end

    def total(num)
      num_nights = @all_reservations[num-1].dates.length - 1
      return num_nights * @rate
    end

    def find_by_date(date)
      by_date = []
      @all_reservations.each_index do |i|
        if @all_reservations[i].dates.include? date
          by_date << @all_reservations[i]
        end
      end
      return by_date
    end

  end #end of California
end #end of Hotel
