
module Hotel
  class Admin
    attr_reader :list_reservations, :rooms

    def initialize
      @rooms = {}
      @list_reservations = []
      create_rooms
    end

    def add_reservation(checkin, checkout)
      dates_to_reserve = Hotel::DateRange.new(checkin, checkout)
      rooms.each do |room_number, dates|
        if  is_room_avaliable?(room_number, dates_to_reserve)
          rooms[room_number] << dates_to_reserve
          make_reservation = Hotel::Reservation.new(checkin, checkout, room_number)
          list_reservations << make_reservation
          return make_reservation
        end #if
      end #each
      raise ArgumentError.new( "There are not avaliable rooms for that date range")
    end

    def reservations_per_day(date)
      list_per_day = []
      list_reservations.each do |reservation|
        if reservation.days_range.include?(date)
          list_per_day << reservation
        end #if
      end #each
      return list_per_day
    end #method

    def create_rooms
      20.times do |i|
        rooms["#{i + 1}"] = []
      end
    end

    def is_room_avaliable?(room_number, dates_to_reserve)
      avaliable = true

      rooms[room_number].each do |busy_dates|
        if dates_to_reserve.overlap?(busy_dates)
          avaliable = false
        end#if
      end
      return avaliable
    end

    def avaliable_rooms_daterange(checkin, checkout)
      avaliable_rooms = []
      date_range = Hotel::DateRange.new(checkin,checkout)
      @rooms.each do |room_number, dates|
        if is_room_avaliable?(room_number, date_range)
          avaliable_rooms  << room_number
        end
      end
      return avaliable_rooms
    end

    def can_create_block?(checkin, checkout, number_of_rooms)
      if number_of_rooms > 5
        raise ArgumentError.new("There is no possible to create a block qith more of 5 rooms")
      else
        if avaliable_rooms_daterange(checkin, checkout).length >= number_of_rooms
          return true
        else
          return false
        end
      end
    end

    def create_block (checkin, checkout, number_of_rooms, price)
      rooms_in_block = []
      if can_create_block?(checkin, checkout, number_of_rooms)
        number_of_rooms.times do
          reserve = add_reservation(checkin, checkout)
          rooms_in_block << reserve.room_number
        end
      end

      Hotel::Block.new(checkin, checkout, rooms_in_block, price)

    end




  end #class

end #module
