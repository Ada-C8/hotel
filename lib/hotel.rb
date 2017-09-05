require_relative 'room'

module Hotel_System
  class Hotel
    attr_reader :number_of_rooms, :rooms
    def initialize(number_of_rooms)
      @number_of_rooms = number_of_rooms
      @rooms = []
      number_of_rooms.times do |i|
        @rooms << Hotel_System::Room.new(i + 1)
      end
    end
  end
end
