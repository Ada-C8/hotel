require 'Date'
require_relative 'Room'

module Hotel
  class Reservation

    attr_reader :start_date, :end_date, :room_num

    @@reservations = []

    def initialize(start_date = Date.today, end_date = Date.today + 1, room_num = 0)
      @start_date = start_date
      @end_date = end_date
      room_num = Room.all.sample[:room_num] if room_num == 0
      @room_num = room_num
      @@reservations.push({room_num: @room_num, start_date: @start_date, end_date: @end_date})
    end

    def total
      rate = 0
      Room.all.each do |room|
        rate = room[:rate] if room[:room_num] == @room_num
      end
      return (@end_date - @start_date) * rate
    end

    def self.all
      return @@reservations
    end


  end # Reservation class
end # Hotel module
