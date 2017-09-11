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
