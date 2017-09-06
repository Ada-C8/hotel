require 'csv'
require_relative 'room'
require_relative 'reservation'
require_relative 'hotel'

module Hotel
  class Block < Reservation
    attr_reader :discount_rate, :num_of_rooms
    def initialize(input_id, input_room_number, check_in_date, check_out_date)
      super
      @discount_rate = input_id
      @num_of_rooms = input_room_number
      raise ArgumentError.new "Blocks can contain a maximum of 5 rooms" if @num_of_rooms > 5
      @id = nil
      @room_number = nil
      @room = nil
    end
  end # => end of Block
end # => end of module
