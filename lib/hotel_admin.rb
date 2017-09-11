# [X] As an administrator, I can access the list of all of the rooms in the hotel
# [X] As an administrator, I can get the total cost for a given reservation
# [X] As an administrator, I can reserve a room for a given date range
# [X] As an administrator, I can reserve an available room for a given date range
# [X] As an administrator, I can access the list of reservations for a specific date
# [X] As an administrator, I can view a list of rooms that are not reserved for a given date range

# [] As an administrator, I can create a block of rooms
# [] To create a block you need a date range, collection of rooms and a discounted room rate
# [] The collection of rooms should only include rooms that are available for the given date range
# [] If a room is set aside in a block, it can't be reserved by the general public, nor can it be included in another block
# [] As an administrator, I can check whether a given block (needs block_id) has any rooms available
# [] As an administrator, I can reserve a room from within a block of rooms

require 'date'
require 'date_range'
require_relative 'room'
require_relative 'reservation'
require_relative 'BookingSystem_Errors'

module BookingSystem
  class HotelAdmin

    attr_reader :room_list, :reservation_list

    def initialize
      #hotel admin knows all collection of reservations
      @reservation_list = []
      #hotel admin knows all rooms in hotel
      @room_list = BookingSystem::Room.all
    end

    def reserve_room(first_name, last_name, room_id, room_rate, start_date, end_date)

      check_availability(room_id, start_date, end_date)

      reservation = BookingSystem::Reservation.new(first_name, last_name, room_id, room_rate, start_date, end_date)
      @reservation_list << reservation
    end

    def check_availability(room_id, start_date, end_date)

      raise InvalidDateRangeError.new("Date range conflicts with room requested")if end_date <= start_date

      requested_range = DateRange.new(start_date, end_date)

      raise UnavailableRoomError.new("Room is unavailable")if @reservation_list.any? {|reservation|
        reservation.room_id == room_id && reservation.date_range.include?(requested_range) && start_date < reservation.end_date
      }
    end

    def find_reservations_by_date(specific_date)
      reservations_on_date = []
      @reservation_list.each do |reservation|
        if reservation.date_range.include?(specific_date)
          reservations_on_date << reservation
        end
      end

      return reservations_on_date
    end

    def rooms_available_for_date_range(date_range)

      raise InvalidDateRangeError.new("Range must be a DateRange object") if !date_range.is_a? DateRange

      unavailable_room_ids = []

      @reservation_list.each do |reservation|
        if reservation.date_range.include?(date_range)
          unavailable_room_ids << reservation.room_id
        end
      end

      available_rooms = @room_list.reject { |room| unavailable_room_ids.include?(room.id) }

      return available_rooms
    end




  end#of_HotelAdmin_class
end#of_module_BookingSystem











# REFACTORED METHODS:
# def rooms_available_for_date_range(date_range)
#   raise InvalidDateRangeError.new("Range must be a DateRange object") if !date_range.is_a? DateRange
#
#   unavailable_room_ids = []
#
#   @reservation_list.each do |reservation|
#     if reservation.date_range.include?(date_range)
#       unavailable_room_ids << reservation.room_id
#     end
#   end
#
#   available_rooms = []
#
#   @room_list.each do |room|
#     if unavailable_room_ids.include?(room.id) == false
#       available_rooms << room
#     end
#   end
#
#   return available_rooms
# end




=begin
Date notes:

<
source: https://stackoverflow.com/questions/3296539/comparision-of-date-in-ruby

.between?(start_date, end_date)
source: https://stackoverflow.com/questions/4521921/how-to-know-if-todays-date-is-in-a-date-range
=end
