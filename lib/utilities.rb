module Utilities
  # (check_in >= reservation.check_in || check_out < reservation.check_out) && room_num == reservation.room.room_number
  def overlap?(other_check_in, other_check_out)
    # return (check_in >= other_check_in || check_out < other_check_out) &&
    #        room.room_number == other_room_num
    return (other_check_in == check_in ||
           (other_check_in < check_in && (other_check_out > check_in && other_check_out < check_out)) ||
           (other_check_in > check_in && other_check_in < check_out))
  end
end
