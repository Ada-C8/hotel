#reservation.rb

require 'awesome_print'

module Hotel_Chain
  class Reservation

    attr_accessor :check_in_date, :check_out_date, :room_id

    #A new reservation object can be initialized by providing the check_in_date and check_out_date
    #Initialization converts the admin's date inputs to convert to Ruby Date objects, and stores them in instance variables.
    #After a reservation is created, this program randomly assigns a room object (without checking to see if it's available).
    #In wave 2, I will create methods to check a spreadsheet to see if the room is available.
    #I may also like to have the program assign a reservation_id (this info can live in a spreadsheet)- then I will need a method to look up a reservation by reservation_id
    def initialize(check_in_date, check_out_date)
      @check_in_date = check_in_date #Date.new(check_in_date)
      @check_out_date = check_out_date #Date.new(check_out_date)
      @hotel = Hotel_Chain::MyHotel.new
      @room_id = @hotel.array_of_rooms.sample.room_id
      #@cost = Date math * 200 (rate will eventually reference the rate associated with the room_id)
    end

  end
end
