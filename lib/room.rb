module Hotel
  class Room
    attr_reader :room_num, :room_rate

    def initialize(room_num, room_rate)
      @room_num = room_num
      @room_rate = room_rate
      puts @room_num #test to make sure room numbers are passed in
    end


  end # end of class

end # end of module

    # # Get all the room objects
    # def self.all
    #   rooms = []
    #   20.times do |i|
    #     rooms << Hotel::Room.new(i + 1)
    #   end
    #   return rooms
    # end
    #
    # def room_availability(date_range)
    #
    # end








#####TESTING#######
# puts room = Hotel::Room.all
# puts room[0]
