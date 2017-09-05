#Hotel.rb
require 'awesome_print'

module Hotel_Chain
  class MyHotel

    attr_reader :no_of_rooms

    def initialize(no_of_rooms = 20)
      @no_of_rooms = no_of_rooms
    end

    #Returns a list of all rooms in the hotel
    def self.std_rate_hotel(no_of_rooms)
      hotel = []
      20.times do |room|
        hotel << Hotel::Room.new(room+1)
      end
      puts "HOTEL ROOMS:"
      ap hotel
      return hotel
    end

    # def set_room_rate()
    # end
    #
    # def create_rooms(no_of_rooms, rate = 200)
    #
    #
    # end
  end
end
