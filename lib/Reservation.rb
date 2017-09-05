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
      @@reservations.push(self)
    end

    def check_dates(start_date, end_date, room_num)
      raise ArgumentError if start_date.class != Date || end_date.class != Date
      raise ArgumentError if end_date <= start_date
      raise ArgumentError if start_date < Date.today
      room_reservations = @@reservations.select { |reservation| reservation.room_num == room_num }
      room_reservations.each do |reservation|
        raise ArgumentError if start_date >= reservation.start_date && start_date < reservation.end_date
        raise ArgumentError if end_date >= reservation.start_date && end_date <= reservation.end_date
      end
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
    
  end # Reservation class
end # Hotel module
