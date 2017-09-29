require 'date'
require 'date_range'
require_relative 'room'
require_relative 'reservation'
require_relative 'BookingSystem_Errors'

module BookingSystem
  class HotelAdmin

    attr_reader :room_list, :reservation_list, :block_list

    def initialize
      #hotel admin knows all reservations (non-block and block)
      @reservation_list = []
      @block_list = []
      #hotel admin knows all rooms in hotel
      @room_list = BookingSystem::Room.all
    end

    def reserve_room(first_name, last_name, room_id, room_rate, start_date, end_date, block_id = nil)

      requested_range = DateRange.new(start_date, end_date)

      if block_id.nil? #if a room doesn't have a block_id, blacklist all rooms that are blocked
        raise UnavailableRoomError.new("Room is unavailable") if @block_list.any? do |block|
          block.date_range.overlaps?(requested_range) && block.rooms_array.any? { |room| room.id == room_id }
        end
      end

      raise UnavailableRoomError.new("Room is unavailable") if @reservation_list.any? {|reservation|
        reservation.room_id == room_id && reservation.date_range.overlaps?(requested_range) && start_date < reservation.end_date
        # reservation.room_id == room_id &&
        # !(reservation.start_date >= end_date || reservation.end_date <= start_date)
      }

      reservation = BookingSystem::Reservation.new(first_name, last_name, room_id, room_rate, start_date, end_date, block_id)
      @reservation_list << reservation
    end

    # Hotel Revisted Changes
    def reserve_block(block_id, date_range, rooms_array, discount_room_rate, reservation_list)

      if @block_list.any? { |block| block.date_range.overlaps?(date_range) }
        @block_list.each do |block|
          rooms_array.each do |room|
            if block.list_room_ids.include?(room.id)
              raise UnavailableRoomError.new("Room is unavailable")
            end
          end
        end
      end

      block = BookingSystem::Block.new(block_id, date_range, rooms_array, discount_room_rate, @reservation_list)
      @block_list << block
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
        if reservation.date_range.overlaps?(date_range)
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
