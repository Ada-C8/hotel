require_relative 'room'
require_relative 'reservation'

module Hotel

  class Hotel

    NUM_ROOMS = 20

    attr_reader :rooms

    def initialize(num_rooms = NUM_ROOMS)
      # check input
      raise ArgumentError.new("Not a valid number of rooms") if !is_valid?(num_rooms)

      @rooms = []

      # loop through num_rooms and add rooms to array
      (1..num_rooms).each do |num|
        @rooms << ::Hotel::Room.new(num)
      end

    end

    private

    def is_valid?(num)
      return num.is_a?(Integer) && num > 0
    end

  end # end of Hotel class

end
