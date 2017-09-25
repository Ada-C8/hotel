# The reservation class will create an instance of a reservation with the following attributes: a reservation ID, the total cost of the reservation, the rooms included in the reservation, and the date range of the reservation (reservation starting on the 5th and ending on the 7th will be an array [5, 6] because the 7th is the checkout date)
# A new instance of a reservation will be created in the Booking class after it verifies that there are rooms availible for the date(s) requested.

module Hotel
  class Reservation
    attr_reader :res_id, :total_cost, :res_rooms, :date_range
    def initialize(res_id, total_cost, res_rooms, date_range)
      @res_id = res_id
      @total_cost = total_cost
      @res_rooms = res_rooms
      @date_range = date_range
    end # initialize
  end # Reservation
end # Hotel
