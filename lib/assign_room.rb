require "date"
require_relative "room"

require "pry"

module Hotel
  class AssignRoom
    attr_accessor :date_range, :room_number

    def initialize(date_range, room_number)
      @date_range = date_range
      @room_number = room_number
    end

  end
end
