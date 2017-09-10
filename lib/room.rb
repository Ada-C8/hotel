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

    def available?(start, nights = 1)
      date_array = date_range(start, nights)
      availability = true

      date_array.each { |date| availability = false if self.nights_reserved.include?(date) || self.blocked_nights.include?(date)}

      return availability
    end #available?

  end #class Room
end #ReservationSystem module
