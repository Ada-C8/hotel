require 'Date'
require_relative 'Reservation'

module Hotel
  class Block

    attr_reader :start_date, :end_date, :discount, :rooms

    @@blocks = []

    def initialize(start_date, end_date, number_of_rooms, discount = 0.1)
      @start_date = start_date
      @end_date = end_date
      @discount = discount
      @rooms = Hotel::Reservation.available(start_date, end_date).sample(number_of_rooms)
      collect_instance
    end

    def collect_instance
      @@blocks.push(self)
    end

  end # Block class
end # Hotel module
