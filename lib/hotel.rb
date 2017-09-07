require_relative 'room'

module ReservationSystem

  #
  #     def self.search_date(date)
  #       list = []
  #
  #       @rooms.each do |room|
  #         #if room.dates_reserved.includes date, add reservation object to the list
  #         @rooms[room].reservations.each do |res, dates|
  #           if dates.includes?(date)
  #             list << res
  #           end
  #         end
  #       end
  #
  #       return list
  #     end
  #
  #   end # Building class
  #
  # end # Hotel module


  #============== OLD WORK ====================#
  class Hotel
    attr_accessor :hotel, :all_reservations, :new_reservation

    def initialize
      @hotel = Array.new
      @all_reservations = Array.new

      20.times do |num|
        @hotel << ReservationSystem::Room.new(num + 1)
      end
    end # initialize

    def reserve(check_in, nights)
      @new_reservation = ReservationSystem::Reservation.new(check_in, nights)
      all_reservations << @new_reservation

    end # reserve

  end #Hotel class

end #ReservationSystem module
