require 'date'
require_relative 'reservation'

module Hotel
  class RoomBlock < Reservation
    attr_reader :type, :available
    attr_accessor :room_price
    def initialize(client, arrival_year, arrival_month, arrival_day, departure_year, departure_month, departure_day, number_of_rooms)
      super
      @room_price = 160
      @type = "Block"
      @available = number_of_rooms
      raise ArgumentError.new("A block must have more than 1 rooms") if @number_of_rooms < 2
      raise ArgumentError.new("A block can't have more than 5 rooms") if @number_of_rooms > 5
    end

    def reserve(num)
      @available < num ? (raise ArgumentError.new("Only #{@available} rooms left.")) : @available -= num
    end
  end
end
