require 'date'
require_relative 'reservation'
require 'pry'

module Hotel
  class RoomBlock < Reservation
    attr_reader :type, :available
    def initialize(client, arrival_date, departure_date, number_of_rooms)
      super
      @room_price = 190.00
      @type = "Block"
      @available = number_of_rooms.to_i
      raise ArgumentError.new("A block must have more than 1 rooms") if @number_of_rooms < 2
      raise ArgumentError.new("A block can't have more than 5 rooms") if @number_of_rooms > 5
    end

    def room_price(price)
      raise ArgumentError.new("Room price can't be negative") if price < 0
      @room_price = price
    end

    def reserve(num)
      @available < num.to_i ? (raise ArgumentError.new("Only #{@available} rooms left.")) : @available -= num.to_i
    end
  end
end
