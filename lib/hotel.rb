module Hotel
  class HotelSystem
    attr_reader :list_of_rooms
    def initialize(number_of_rooms)
      raise ArgumentError.new("number_of_rooms must be an integer")if number_of_rooms.class != Integer
      @list_of_rooms = Array.new
      number_of_rooms.times do |i|
        @list_of_rooms << Room.new
      end
    end
  end
end
