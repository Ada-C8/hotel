module Hotel
  class BlockReservation < Reservation
    attr_reader :check_in, :check_out, :rooms
    #initialize
    #initialize would now take in check_in, check_out, and an Array of Room objects
    def initialize(check_in, check_out, rooms)
      @check_in = check_in
      @check_out = check_out
      @rooms = rooms
    end
    #change_availability

    #overlap?

  end
end
