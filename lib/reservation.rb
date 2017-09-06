#reservation.rb

require 'awesome_print'
require 'date'

module Hotel_Chain
  class Reservation

    attr_accessor :check_in_date, :check_out_date, :room_id, :hotel, :cost

    #A new reservation object can be initialized by providing the check_in_date and check_out_date
    #Initialization converts the admin's date inputs to convert to Ruby Date objects, and stores them in instance variables.
    #After a reservation is created, this program randomly assigns a room object (without checking to see if it's available).
    #In wave 2, I will create methods to check a spreadsheet to see if the room is available.
    #I may also like to have the program assign a reservation_id (this info can live in a spreadsheet)- then I will need a method to look up a reservation by reservation_id
    def initialize(check_in_date, check_out_date)
      @check_in_date = Date.strptime(check_in_date, "%m/%d/%Y")
      @check_out_date = Date.strptime(check_out_date, "%m/%d/%Y")
      @hotel = Hotel_Chain::MyHotel.new
      @room_id = @hotel.array_of_rooms.sample.room_id
      @cost = (@check_out_date - @check_in_date) * 200 
      #(rate will eventually reference the rate associated with the room_id)
      puts "Check-in date: #{@check_in_date}"
      puts "Cost: #{@cost}"
    end

  end
end

# check_in_date = "8/13/17"
# check_out_date = "8/16/17"
# reservation = Hotel_Chain::Reservation.new(check_in_date, check_out_date)
# puts reservation.check_in_date
