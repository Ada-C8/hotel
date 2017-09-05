### Booking Program class that holds all of the business logic for the hotel and the reservation system

module Hotel
  # NUMBER_OF_ROOMS = 20  ### might not want to use constant, especially if we have subclasses of rooms (by type), and each room subclass might have a different number. may best be a constant defined by class/subclass

  class BookingProgram
    #rooms = Hotel::Room.all # returns an array or hash of Room objects

    #reservations = Hotel::Reservation.all #returns an array or hash of Reservation Objects

  #  puts " rooms: #{rooms} \n reservations: #{reservations}"


  end
end
