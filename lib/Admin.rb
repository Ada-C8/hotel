require_relative 'reservation'
require_relative 'block'

module Hotel
  class Admin

    attr_reader :room_nums, :blocks

    def initialize
      @blocks = []
      @room_nums = []
      20.times do |i|
        @room_nums << (i + 1)
      end
    end



    def list_of_rooms
      return Array.new(room_nums)
    end



    def add_block(room_num_array, check_in, check_out, discount_percent: 0.0)
      @blocks << Hotel::Block.new(room_num_array, check_in, check_out, discount_percent: 0.0)
    end

    #TODO
    #TODO:
    # def list_reservations(date)
    #   block_by_date = []
    #
    #   @blocks.each do |block|
    #     if block.date_range_array.include?(date)
    #       block_by_date << block
    #     end
    #   end
    #   return block_by_date
    # end


    # lists room vacancies that can be utilized for booking available rooms
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
    def create_block_by_date(rooms_per_block, check_in, check_out, discount_percent: 0.0)
      room_num_array = self.list_vacancies(check_in, check_out).sample(rooms_per_block).to_a
      @blocks << Hotel::Block.new(room_num_array, check_in, check_out, discount_percent: 0.0)
    end
  end # end class
end # end module
