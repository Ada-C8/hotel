require_relative
# The hotel has 20 rooms, and they are numbered 1 through 20
# Every room is identical, and a room always costs $200/night
# The last day of a reservation is the checkout day,
# so the guest should not be charged for that night
# For this wave, any room can be reserved at any time,
# and you don't need to check whether reservations
# conflict with each other (this will come in wave 2!)

module Hotel
  class Room
    @room_number = room_number
    @room_price = 200
  end

end
