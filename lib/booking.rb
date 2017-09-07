# Booking will do a lot of things:
# It will initialize all the instances of the Room class (with room_number 1-20)
# it will be initialized with an emty array @all_reservations and an array @all_rooms that containts the 20 initialized instances of Room
# It will initialize all the instances of the Room class (with room_number 1-20)
# It will have an instance variable @all_reservations which will be an array of all the Reservation instances created in the Booking class
# It will have a method that makes a new reservation
# Before it creates a new Reservation it will need to verify that the hotel has vacancy for the date(s) in question
#Once it verifies that there is availiblility it will create a new instance of Reservation with a reservation_id (unique to each Reservation @all_reservations.length + 1? ), total_cost (# of rooms * number of nights * cost of a room), res_rooms (the instsances of the Room class that are included in the Reservation, identified by Room.room_number), date_range (get from the user as a starting and ending date and pass to DateRange to get the date_range argument)
# using the availible array we can iterate though the array to create new Reservation for the date(s) requested with the right rooms (only the ones in the availible array)
# it will have a method that checks if there is a reservation for the date(s) requested
# iterate though @all_reservations for each day requested and if the day is included in the Booking then it will look at the Reservation that included that date and add the room(s) in that reservation to a new array not_availible.
# it will have a method that checks if there is availiblility for the date(s) requested
# if the size of not_availible is 20, then there is no availiblility for that date
# if  20 - not_availible.length > the number of rooms requested then there is availibility for those dates
# then should create the inverse array of not_availible, which i'll call availible
# In ithe make_reservation method: using the availible array we can iterate though the array to create a new Reservation for the date(s) requested with the right rooms (only the ones in the availible array)


module Hotel
  class Booking
    attr_reader :all_reservations, :all_rooms
    def initialize
      @all_reservations = []
      @all_rooms = []

      (1..20).each do |number|
        @all_rooms << Hotel::Room.new(number)
      end
    end # initialize

    def make_reservation(start_date, end_date, num_rooms )
      if end_date < start_date
        raise ArgumentError.new("Your checkout day must be after your checkin date! You entered: checkin day = #{start_date} and checkout date = #{end_date}")
      else
        dates_booked = Hotel::DateRange.new(start_date, end_date).nights_booked
        reservation_id = @all_reservations.length + 1
        rooms = []
        i = 0
        num_rooms.times do
          rooms << @all_rooms[i]
          i += 1
        end # TODO: later I need to change this to pull from the availible rooms array (wave 2)
        cost = (num_rooms * dates_booked.length * 200.0)

        @all_reservations << Hotel::Reservation.new(reservation_id, cost, rooms, dates_booked)
      end # if/else
    end # make_reservation

    def check_date_for_reservations(start_date, end_date)
      # TODO: change this to allow for a date range instead! Wave 2
      # it will have a method that checks if there is a reservation for the date(s) requested
      # iterate though @all_reservations for each day requested and if the day is included in the Booking then it will look at the Reservation that included that date and add the room(s) in that reservation to a new array not_availible.
      days = Hotel::DateRange.new(start_date, end_date).nights_booked
      date_reservations = []

      days.each do |day|
        @all_reservations.each do |res|
          if res.date_range.include?(day)
            date_reservations << res
          end # if
        end # .each
      end #.each
      return date_reservations
    end # check_date_for_reservations

    def print_reservations(start_date, end_date)
      # Not sure if we need this and if simply calling check_date_for_reservations is enough for the user to be able to access all the reservations for a given date(range)
      reservations = check_date_for_reservations(start_date, end_date)
      nice_format_reservations = []
      reservations.each do |res|
        loop_array = []
        loop_array << "Reservation ID: #{res.res_id}"
        loop_array << "Total cost: $#{res.total_cost}"
        list_rooms = ""
        res.res_rooms.each do |room|
          list_rooms << " #{room.room_number},"
        end #.each
        loop_array << "Rooms reserved: #{list_rooms}"
        loop_array << "Date range: #{res.date_range[0]} - #{res.date_range[-1] + 1}"
        nice_format_reservations << loop_array
      end
      return nice_format_reservations
    end #print_reservations

    def availible_rooms(start_date, end_date)
      reservations = check_date_for_reservations(start_date, end_date)
      reserved = []
      availible = []

      #creates an array of all the rooms that are reserved for the given date range
      reservations.each do |res|
        res.res_rooms.each do |room|
          reserved << room
        end # .each
      end # .each

      # creates an array of all the availible rooms for the given date range
      @all_rooms.each do |room|
        if !(reserved.include?(room))
          availible << room
        end # if
      end # .each

      return availible
    end # availible_rooms

  end # Booking
end # Hotel
