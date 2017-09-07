module Hotel

  class Hotel

    attr_reader :list_of_rooms, :price, :collection_of_reservations

    def initialize(num_of_rooms, price)
      @list_of_rooms = []
      room_num = 0
      num_of_rooms.times do |room|
        room_num += 1
        @list_of_rooms << room_num
      end #loop

      @price = price
      @collection_of_reservations = []
    end #initialize

    # def list_of_rooms
    #   @list_of_rooms.each do |room|
    #     puts "Room #{room}"
    #   end
    # end #list_of_rooms
    # not needed for this more abstract hotel class
    

  end #class

end #module
