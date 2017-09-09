require 'pry'
module Hotel
  class BlockReservation < Reservation
    attr_reader :check_in, :check_out, :rooms, :rate
    #initialize
    #initialize would now take in check_in, check_out, and an Array of Room objects
    def initialize(check_in, check_out, rooms)
      raise ArgumentError.new("There's only one room in the rooms parameter. Try creating a regular reservation instead") if rooms.length <= 1
      @check_in = check_in
      @check_out = check_out
      @rooms = rooms # assumes in each block there's always more than 1
      @rate = (0.05 * rooms.length).round(2) # in decimal (10%, 15%, 20%, 25%)
    end
    #change_availability

    #overlap?

    def total_cost
      cost = 0
      @rooms.each do |room|
        if room.available
          cost += room.cost
        end
      end
      total_days = (check_out - check_in).to_i
      cost *= total_days
      return (cost - (cost * rate)).to_i
    end

  end
end
