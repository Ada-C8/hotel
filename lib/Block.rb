
module Hotel
  class Block < DateRange
    attr_accessor :check_in, :check_out, :date_range, :dates, :block_rooms_collection, :discounted_room_rate, :available_rooms, :booked, :block_name, :number_of_rooms
    def initialize(check_in, check_out, block_name, block_rooms_collection = [], discounted_room_rate = 180)

      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)
      @date_range = Hotel::DateRange.new(check_in, check_out)
      @dates = @date_range.dates
      # @dates = Hotel::DateRange.new(@check_in, @check_out).dates
      @block_rooms_collection = block_rooms_collection
      @discounted_room_rate = discounted_room_rate
      @booked = []
      @block_name = block_name
      #@available_rooms = @block_rooms_collection
      # @number_of_rooms = number_of_rooms
      # create_block_rooms_collection
      # Hotel::Reservations.blocks_collection << Self
    end


    # def create_block_rooms_collection
    #   unless @number_of_rooms <= 5 && @number_of_rooms >= 1
    #     raise ArgumentError.new("Blocks can only have between 1 and 5 rooms.")
    #   end
    #   rooms_available = Hotel::Reservations.rooms_collection
    #   @dates.each do |date|
    #     Hotel::Reservations.list_reservations_by_date(date).each do |booking|
    #       rooms_available.each do |room|
    #         if room.room_number == booking.room_number
    #           rooms_available.delete(room)
    #         end
    #       end
    #     end
    #   end
    #   @block_rooms_collection = []
    #
    #   @number_of_rooms.times do |i|
    #     @block_rooms_collection << rooms_available[i]
    #   end
    #   return @block_rooms_collection
    # end


    def has_rooms_available?
      if !(@booked.length < @block_rooms_collection.length)
        return false
      else
        return true
      end
    end




  end
end
