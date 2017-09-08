require_relative 'reservable'
require_relative 'hotel'

module ReservationSystem

  class Room
    include Reservable

    attr_reader :number, :rate
    attr_accessor :nights_reserved

    def initialize(number)
      positive_integer?(number)
      @number = number
      @rate = 200 #TODO decide: could be a constant?
      @nights_reserved = Array.new
    end

    def available?(start, nights = 1) #TODO consider changing input to just date_range
      date_array = date_range(start, nights)
      availability = true

      date_array.each { |date| availability = false if self.nights_reserved.include?(date) }

      return availability
    end #available?

  end #class Room
end #ReservationSystem module
