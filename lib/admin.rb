
module Hotel
  class Admin
    attr_reader :list_reservations

    def initialize
      @list_rooms = []
      20.times do |i|
        @list_rooms << i
      end
      @list_reservations = []
    end

    def add_reservation(checkin, checkout)
      newreservation = Hotel::Reservation.new(checkin, checkout)
      @list_reservations << newreservation
    end

    def reservations_per_day(date)#hacer esto
      list_per_day = []
      @list_reservations.each do |reservation|
        if reservation.days_range.include?(date)
          list_per_day << reservation
        end #if
      end #each
      return list_per_day
    end #method



  end #class

end #module
