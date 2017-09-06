require 'date'
require_relative 'hotel.rb'
require_relative 'reservations.rb'

module Hotel_System

  class Room
    attr_reader :room_number, :reserved

    attr_accessor :price

    def initialize(room_num, price)
      @room_number = room_num
      @price = price
    end

  end
end
