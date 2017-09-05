module Hotel

  class Reservation
    #dates, check in check out, cost, id
# As an administrator, I can access the list of all of the rooms in the hotel
# As an administrator, I can reserve a room for a given date range
# As an administrator, I can access the list of reservations for a specific date
# As an administrator, I can get the total cost for a given reservation


  end

  class Hotel_Rooms
    attr_reader :number, :id, :rate

    def initialize(number)
      @number = number
      @id = id 
      @rate = rate
    end

    def self.all
      rooms = []
      number = 0
      20.times do
        number += 1
        rooms << self.new(number)
      end
    end

    #xnumber of rooms numbered 1-20
    #cost 200/night/rooms
    #make sure only charged for when occupied, not check out
    #error for invalid date range









  end #end of class
end #end of module
