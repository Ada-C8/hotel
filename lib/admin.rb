
module Hotel
  class Admin
    attr_reader :list_reservations, :rooms

    def initialize
      @rooms = {}
      @list_reservations = []
      create_rooms
    end

    def add_reservation(checkin, checkout)
      room_number = 1
      newreservation = Hotel::Reservation.new(checkin, checkout, room_number)
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

    def create_rooms
      20.times do |i|
        @rooms["#{i + 1}"] = []
      end
    end



  end #class

end #module
