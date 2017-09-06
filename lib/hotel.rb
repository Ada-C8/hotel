module Hotel
  class Hotel

    attr_reader :reservations, :rooms

    def initialize
      @reservations = [] #where reservation objects are pushed
      @rooms = {room1:200, room2:200, room3:200, room4:200, room5:200, room6:200, room7:200,
        room8:200, room9:200, room10:200} #roomnumber:price
    end


    # def view_available(range_of_dates)
    #   available = []
    #   @reservations.each do |reservation|
    #     reservation.date_range.each do |date| #does not include date_range
    #       available << reservation
    #     end
    #   end
    # end

    #
    # def view_booked(date)
    # end
    #
    # def make_reservation(date_range, room)
    #   reservation = Hotel::Reservation.new(id, date1, *date2, room_number, cost)
    #   @reservations << reservation
    # end
    #

  end #end of class
end #end of module
