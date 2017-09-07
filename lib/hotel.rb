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

end # Tools module

module ReservationSystem
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

    def reserve(check_in, nights)
      valid_date?(check_in)
      positive_integer?(nights)
      @new_reservation = ReservationSystem::Reservation.new(check_in, nights)
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

  end #Hotel class

end #ReservationSystem module
