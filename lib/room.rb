require_relative 'reservable'
require_relative 'hotel'

module ReservationSystem

  class Room
    include Reservable

    attr_reader :number
    attr_accessor :nights_reserved, :blocked_nights, :rate

    def initialize(number)
      positive_integer?(number)
      @number = number
      @rate = ReservationSystem::Hotel::BASE_ROOM_RATE
      @nights_reserved = Array.new
      @blocked_nights = Array.new
    end

    def change_rate(rate)
      @rate = rate
    end

    def add_nights_reserved(check_in_date, nights)
      @nights_reserved += date_range(check_in_date, nights)

    end

    def not_reserved?(start, nights = 1)
      date_array = date_range(start, nights)
      availability = true

      date_array.each { |date| availability = false if self.nights_reserved.include?(date)}

      return availability
    end # not_reserved?

    def not_blocked?(start, nights = 1)
      date_array = date_range(start, nights)
      availability = true

      date_array.each { |date| availability = false if  self.blocked_nights.include?(date)}

      return availability
    end #not_blocked?

  end #class Room
end #ReservationSystem module
