require 'date'
require_relative 'building'


module Hotel

  class Reservation
    #attr
    attr_accessor :check_in, :nights, :room

    #constants

    #initialize
    def initialize(check_in_date, nights, room)
      @check_in = Date.parse(check_in_date)
      @nights = nights
      @room = room
    end
    #class methods

    #instance methods


  end # Reservation class

end # Hotel module
