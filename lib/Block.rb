require 'Date'
require_relative 'Reservation'

module Hotel
  class Block < Reservation

    def initialize(start_date, end_date, number_of_rooms, discount = 0.1)
      @start_date = start_date
      @end_date = end_date
      @discount = discount
      @rooms = []
    end

  end # Block class
end # Hotel module
