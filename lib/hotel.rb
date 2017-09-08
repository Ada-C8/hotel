require_relative 'room'

module Tools
  class DateError < StandardError
  end #DateError class

  def valid_date?(date)
    unless date.kind_of? Date
      raise DateError.new("Invalid Date! You submitted #{date}, which is not a Date object.")
    end
  end # valid_date? method

  class PositiveIntegerError < StandardError
  end

  def positive_integer?(num)
    unless (num.kind_of? Integer) && num > 0
      raise PositiveIntegerError.new("Invalid number! You submitted #{num}, which is not a positive integer.")
    end
  end # positive_integer? method

  # TODO rescue valid_date and positive_integer

  #TODO Validate room

  def to_date_range(start, nights)
    array = Array.new
    nights.times {|i| array << start + i}
    return array
  end

  def available?(room, date_range)
    #TODO setup
  end

end # Tools module

module ReservationSystem
#TODO Go through each file and auto indent
  class Hotel
    include Tools

    attr_accessor :hotel, :all_reservations, :new_reservation

    def initialize
      @hotel = Array.new
      @all_reservations = Array.new

      20.times do |num|
        @hotel << ReservationSystem::Room.new(num + 1)
      end
    end # initialize

    def reserve(check_in, nights, room)
      valid_date?(check_in)
      positive_integer?(nights)
      # TODO validate room is available
      @new_reservation = ReservationSystem::Reservation.new(check_in, nights, room)
      all_reservations << @new_reservation
      return @new_reservation
    end # reserve

    def search_reservations_by_date(date)
      valid_date?(date)
      list = Array.new

      all_reservations.each do |res|
        if res.dates_reserved.include?(date)
          list << res
        end
      end

      return list
    end # search_reservations_by_date

    def search_available_rooms_by_dates(start, nights)
      rooms = hotel.dup
      date_array = to_date_range(start, nights)
      date_array.each do |date|
        hotel.each do |room|
          if room.nights_reserved.include?(date)
            rooms.delete(room)

          end
        end
      end

      return rooms
    end # "search_available_rooms_by_dates"

  end #Hotel class

end #ReservationSystem module
