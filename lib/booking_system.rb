require_relative 'room'
require_relative 'reservation'
require_relative 'date_range'
require 'date'

module Hotel
  class BookingSystem
    attr_reader :collection_of_rooms, :collection_of_reservations

    #Access list of all rooms in the hotel.
    def initialize
      @collection_of_rooms = []
      build_rooms
      # 20.times do |i|
      #   room = Hotel::Room.new(i + 1, 200)
      #   @collection_of_rooms << room
      # end
      @collection_of_reservations = []
    end

    def build_rooms
      20.times do |i|
        room = Hotel::Room.new(i + 1, 200)
        @collection_of_rooms << room
      end
    end

  end #end of class
end #end of module
