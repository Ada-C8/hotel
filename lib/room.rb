require_relative 'hotel'

module ReservationSystem

  class Room
    include Tools

    attr_reader :number, :rate
    attr_accessor :nights_reserved

    def initialize(number)
      positive_integer?(number)
      @number = number
      @rate = 200 #TODO decide: could be a constant?
      @nights_reserved = Array.new
    end

  end #class Room
end #ReservationSystem module
