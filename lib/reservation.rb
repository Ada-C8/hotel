require 'date'
require_relative 'building'


module Hotel

  class Reservation
    #attr
    attr_reader :all, :list
    attr_accessor :check_in, :nights, :room

    #constants

    #variables
    @@list = []

    #initialize
    def initialize(check_in_date, nights, room)
      @check_in = Date.parse(check_in_date)
      @nights = nights
      @room = room
      @@list << self
    end
    #class methods
    def self.all
      return @@list
    end
    #instance methods


  end # Reservation class

end # Hotel module
