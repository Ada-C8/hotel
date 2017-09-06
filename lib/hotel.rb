module Hotel
  class Hotel

    attr_reader :reservations, :rooms

    def initialize()
      @reservations = [] #where reservation objects are pushed
      @rooms = {} #roomnumber:price
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
    #   reservation = Hotel::Reservation.new
    #   @reservations << reservation
    # end
    #

  end #end of class
end #end of module
