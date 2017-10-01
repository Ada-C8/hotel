#reservation.rb

require 'awesome_print'
require 'date'

module Hotel_Chain
  class Reservation

    attr_accessor :check_in_date, :check_out_date, :room, :HOTEL, :cost, :status, :block_reserved

    HOTEL = Hotel_Chain::Hotel.new

    #A new reservation object can be initialized by providing the check_in_date and check_out_date
    #Initialization converts the admin's date inputs to convert to Ruby Date objects, and stores them in instance variables.
    #After a reservation is created, this program randomly assigns a room object (without checking to see if it's available).
    #I may also like to have the program assign a reservation_id (this info can live in a spreadsheet)- then I will need a method to look up a reservation by reservation_id
    #reservation_ID would be set as default value of 0 here and then set in the store_reservation method based on existing reservations.
    def initialize(check_in_date, check_out_date, status = "assigned")
      begin
        @check_in_date = Date.strptime(check_in_date, "%m/%d/%Y")
        @check_out_date = Date.strptime(check_out_date, "%m/%d/%Y")
        @room = HOTEL.rooms.sample
        @status = "assigned" #all reservations default to "assigned", unless they are reservations made in a block
        @block_reserved = false #defaults to false. the reserve_block method changes this to true.
      rescue ArgumentError
        raise WrongDateFormatError
      end
    end

  end
end
