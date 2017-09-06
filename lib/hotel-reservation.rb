require 'Date'
require 'Awesome_Print'

module Hotel
  class Reservation
    @@all_reservations = []

    attr_reader :start_date, :end_date, :room, :total_cost

    def initialize(start_date, end_date, room)
      if end_date > start_date
        @start_date = start_date
        @end_date = end_date
      else
        raise ArgumentError.new "End date is before start date"
      end
      #move to script! Date.valid_date?()
      # puts room.available?(start_date, end_date)
      if room.available?(start_date, end_date)
        @room = room
      else
        raise ArgumentError.new "Room is not available"
      end
      @number_of_nights = (@end_date - @start_date).to_i
      @total_cost = (200 * @number_of_nights).round(2)
      @@all_reservations << self
    end

    def self.list_for_date(date)
      list_of_reservations = []
      @@all_reservations.each do |reservation|
        if (reservation.start_date...reservation.end_date).include?(date)
          list_of_reservations << reservation
        end
      end
      return list_of_reservations
    end

    def self.list_all
      return @@all_reservations
    end

  end
end
