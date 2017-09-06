require 'Date'
require_relative 'Room'

module Hotel
  class Reservation

    attr_reader :start_date, :end_date, :room_num

    @@reservations = []

    def initialize(start_date = Date.today, end_date = Date.today + 1, room_num = 0)
      @start_date = start_date
      @end_date = end_date
      room_num = Room.all.sample.room_num if room_num == 0
      @room_num = room_num
      check_dates(start_date, end_date, room_num)
      collect_instance
    end

    def collect_instance
      @@reservations.push(self)
    end

    def total
      rate = 0
      Room.all.each do |room|
        rate = room.rate if room.room_num == @room_num
      end
      return (@end_date - @start_date) * rate
    end

    def self.all(date = nil)
      return @@reservations if date == nil
      return @@reservations.select { |reservation| reservation.start_date <= date && reservation.end_date >= date }
    end

    def self.available(start_date, end_date)
      return @@reservations.select do |reservation|
        self.overlapping?(start_date, end_date, reservation.start_date, reservation.end_date) == false
      end
    end

    private

    def check_dates(start_date, end_date, room_num)
      # prevent invalid dates
      raise ArgumentError if start_date.class != Date || end_date.class != Date
      raise ArgumentError if end_date <= start_date
      raise ArgumentError if start_date < Date.today
      # prevent double booking
      room_reservations = @@reservations.select { |reservation| reservation.room_num == room_num }
      room_reservations.each do |reservation|
        raise ArgumentError if self.overlapping?(start_date, end_date, reservation.start_date, reservation,end_date)
      end
    end

    def self.overlapping?(start_date, end_date, comparison_start_date, comparison_end_date)
      # start date is within comparison date range
      return true if start_date >= comparison_start_date && start_date < comparison_end_date
      # end date is within comparison date range
      return true if end_date >= comparison_start_date && end_date <= comparison_end_date
      return false
    end


  end # Reservation class
end # Hotel module
