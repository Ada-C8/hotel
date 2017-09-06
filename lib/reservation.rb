require 'date'
require_relative 'building'


module Hotel

  class Reservation
    #attr
    attr_reader :all, :list
    attr_accessor :check_in, :nights, :room, :check_out

    #constants

    #variables

    #initialize
    def initialize(check_in_date, nights, room)
      @check_in = Date.parse(check_in_date)
      @nights = nights
      @room = room
      @check_out = @check_in + nights #NOTE excessive, but helpful for my head wrapping around the dates
    end
    #class methods

    #instance methods


  end # Reservation class

end # Hotel module
