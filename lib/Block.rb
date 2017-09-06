require 'Date'

module Hotel
  class Block

    attr_reader :start_date, :end_date, :discount, :rooms

    @@blocks = []

    def initialize(start_date, end_date, number_of_rooms, discount = 0.1)
      raise ArgumentError.new("Blocks can have between 1 and 5 rooms") if (1..5).to_a.include?number_of_rooms == false
      @start_date = start_date
      @end_date = end_date
      @discount = discount
      @rooms = Hotel::Reservation.available(start_date, end_date).sample(number_of_rooms)
      raise NoRoomsAvailableError if @rooms.length < number_of_rooms
      collect_instance
    end

    def collect_instance
      @@blocks.push(self)
    end

    def self.available(start_date, end_date)
      available_rooms = Room.all.map { |room| room.room_num }
      overlapping_blocks = @@blocks.select do |block|
        self.overlapping?(start_date, end_date, block.start_date, block.end_date) == true
      end
      overlapping_blocks.each do |block|
        block.rooms.each do |room|
          available_rooms.delete(room) if available_rooms.include?(room)
        end
      end
      return available_rooms
    end

    private

    def self.overlapping?(start_date, end_date, comparison_start_date, comparison_end_date)
      # start date is within comparison date range
      return true if start_date >= comparison_start_date && start_date < comparison_end_date
      # end date is within comparison date range
      return true if end_date >= comparison_start_date && end_date <= comparison_end_date
      return false
    end

  end # Block class
end # Hotel module
