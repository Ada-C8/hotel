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

# TODO check that start_date is before end_date, if not then raise Error

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
      dates_booked = Hotel::DateRange.new(start_date, end_date).nights_booked
      reservation_id = @all_reservations.length + 1
      rooms = []
      i = 0
      num_rooms.times do
        rooms << @all_rooms[i]
        i += 1
      end # TODO: later I need to change this to pull from the availible rooms array
      cost = (num_rooms * dates_booked.length * 20.0)

      @all_reservations << Hotel::Reservation.new(reservation_id, cost, rooms, dates_booked)
    end # make_reservation

    # def check_date_for_reservations
    # end # check_date_for_reservations
  end # Booking
end # Hotel
