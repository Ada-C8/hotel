require "date"
require_relative "room"
require_relative "reservation"
require_relative "date_range"

require "pry"

module Hotel
  class Hotel

    attr_accessor :rooms, :reservations

    def initialize
      @rooms = Room.all
      @reservations = []
    end

    def available_room
      #takes rooms with no reservations
      res_nums = []
      @reservations.each do |res|
        res_nums << res.room_number.num
      end
      @rooms.each do |room|
        unless res_nums.include? room.num
          return room #returns first instance
        end
      end
    end

    def reserve_room(check_in, check_out, available_room)
      dates = DateRange.new(check_in, check_out).date_range
      if available_rooms_during(check_in, check_out).include? available_room
        @reservations << Reservation.new(dates, available_room)
      else
        raise ArgumentError.new("This room isn't available")
      end
    end

    def reservations_by_date(date) #find reservations by date
      array = []
      @reservations.each do |arr|
        if arr.dates.include? date
          array << arr
        end
      end
      return array
    end

    def available_rooms_during(check_in, check_out)
      dates = DateRange.new(check_in, check_out).date_range
      #available rooms during requested date range
      #date_range must first be defined
      #list all rooms that will be available
      available_rooms = []

      #takes rooms with no reservations
      res_nums = []
      @reservations.each do |res|
        res_nums << res.room_number.num
      end
      @rooms.each do |room|
        unless res_nums.include? room.num
          available_rooms << room
        end
      end

      #takes available rooms in date_range from @reservations
      @reservations.each do |res|
        nights = res.dates
        nights.pop #removes check out day
        if (nights & dates).empty?
          available_rooms << res
        end
      end

      return available_rooms
    end

  end #end class reservation
end #end module Hotel
