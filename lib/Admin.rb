require_relative 'reservation'
require_relative 'block'
require 'pry'
require 'date'

module Hotel
  class Admin

    attr_reader :blocks, :room_nums, :reservations_array

    def initialize
      @blocks = []
      @room_nums = []
      20.times do |i|
        @room_nums << (i + 1)
      end

      # @reservations_array1 = []

    end # end initialize



    def list_of_rooms
      return Array.new(room_nums)
    end


    # I do not remember why I had this method. Kept it for future reference.
    # def add_block(room_num_array, check_in, check_out, block_id, discount_percent: 0)
    #   @blocks << Hotel::Block.new(room_num_array, check_in, check_out, block_id, discount_percent: 0)
    # end

    # Wave 2 requirement. Add reservation only no block
    # Kept this code because wave 2 requires it. As for instructor feedback provided after first submition. Please see the create_block_by_date method on line 87'ish
    def add_reservation(room_selection, check_in, check_out)
      # self.add_block()
      # self.add_reservation_to_block()
      @reservations << Hotel::Reservation.new(room_selection, check_in, check_out)
    end


    def list_reservations(date)
      rez_by_date = []
      @blocks.each do |block|
        if block.block_date_range_array.include?(date)
          block.reservations_array.each do |reservation|
            rez_by_date << reservation
          end
        end
      end
      return rez_by_date
    end

    # def list_blocks(date)
    #   blocks_by_date = []
    #
    #   @blocks.each do |block|
    #     if block.block_date_range_array.include?(date)
    #       blocks_by_date << block
    #     end
    #   end
    #   return blocks_by_date
    # end


    # to find the vacancies by date range we need to look at all the blocked rooms and then remove each room from the list

    def list_vacancies(check_in, check_out)
      available_rooms = list_of_rooms

      date_range = DateRange.new(check_in, check_out).date_range_array

      date_range.each do |date|
        @blocks.each do |block|
          if block.block_date_range_array.include?(date)
            block.room_num_array.each do |room_num|
              available_rooms.delete(room_num)
            end
          end
        end
      end # end date_range loop
      return available_rooms
    end

    # creates block with available room for a given date range.
    def create_block_by_date(rooms_per_block, check_in, check_out, block_id, discount_percent: 0.0)
      while self.list_vacancies(check_in, check_out).empty?
        raise StandardError("No more vacancies!")
      end

      room_num_array = self.list_vacancies(check_in, check_out).take(rooms_per_block).to_a

      # @blocks << Hotel::Block.new(room_num_array, check_in, check_out, block_id, discount_percent: 0.0)

      # take one of the rooms from the room_num_array to make a reservation
      room_num = room_num_array.first

      new_block = Hotel::Block.new(room_num_array, check_in, check_out, block_id, discount_percent: 0.0)

      new_block.make_reservation(room_num, check_in, check_out, discount_percent: 0)

      @blocks << new_block
    end

    def find_block(id)
      @blocks.each do |block|
        if block.block_id == id
          return block
        end
      end
    end

    def list_available_blocked_rooms(id)
      #find the block.
      # access its assigned rooms
      return self.find_block(id).room_num_array
    end


    def find_rooms_from_block(id, num_rooms_to_reserve)
      return self.list_available_blocked_rooms(id).take(num_rooms_to_reserve)
    end


    def add_reservation_to_block(id, num_rooms_to_reserve, check_in, check_out, discount_percent: 0)
      block = self.find_block(id)
      num_rooms_to_reserve = self.find_rooms_from_block(id, num_rooms_to_reserve)

      num_rooms_to_reserve.length.times do |room_num|
        # block.reservations_array << Hotel::Reservation.new(room_num, check_in, check_out, discount_percent: 0)
        block.make_reservation(room_num, check_in, check_out, discount_percent: 0)
      end
    end
  end # end class
end # end module
