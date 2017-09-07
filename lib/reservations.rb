require 'date'
module Hotel
  class Reservations

    attr_reader :all_reservations, :rooms, :all_rooms, :not_available, :available, :booking

    def initialize
      # @all_rooms = [1..20] # do I need all_rooms?
      # @rooms = Room.new.room_number
      # @room_cost = 0 # do I need this? I have cost over in booking
      # @cost = Room.new.cost
      @all_rooms = []
      create_rooms(@all_rooms) # write test that rooms are created

      @all_reservations = []
    end


    def create_rooms(all_rooms)
      20.times do |i|
        num = i + 1
        all_rooms << Room.new(num)
      end
    end

    # Booking.new(checkin, checkout, check_availablity[0])

    def make_booking(checkin, checkout, num_of_rooms = 1)
      # do we have an availability?
      # if yes, Reservation.new and push into @all_reservations
      # make id here and pass into booking
      # date_range = DateRange.new(checkin, checkout)
      availability = check_availability(checkin, checkout)
      if availability.length < num_of_rooms
        raise ArgumentError.new "Sorry, we don't have enough rooms."
      elsif availability == []
        raise ArgumentError.new "Sorry, we don't have any rooms avaialble."
      end

      id = @all_reservations.length
      rooms = availability.take num_of_rooms

      booking = Booking.new(checkin, checkout, rooms, id)
      @all_reservations << booking
      return booking
    end


    ##########################
    def check_reservations(checkin, checkout)
      # need to check each find date
      # if reservation.date.include? (date_range[0])
      #   not_available << room
      check_against = DateRange.new(checkin, checkout).night_array
      not_available = []

      check_against.each do |date|
        # check_against.each do |index|

        @all_reservations.each do |booking|
          if booking.dates.include?(date)
            booking.rooms.each do |room|
              not_available << room
            end
          end
        end
      end
      return not_available
    end

    def check_availability(checkin, checkout)
      # this is the inverse of not_available array
      available = []
      @all_rooms.each do |room|
        unless check_reservations(checkin, checkout).include?(room)
          available << room
        end
      end
      return available
    end
  end
end
