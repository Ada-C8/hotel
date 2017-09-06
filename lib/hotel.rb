module Hotel
  class Hotel
    attr_reader :number_of_rooms, :list_of_rooms
    def initialize(number_of_rooms)
      @number_of_rooms = number_of_rooms.to_i
      @list_of_rooms = []
      number_of_rooms.times {|i| @list_of_rooms << Room.new(i+1)}
    end
  end
end
