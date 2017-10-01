require 'date'

module Administration
  class Room

    attr_reader :room_num

    def initialize(room_num)
      @room_num = room_num

      raise ArgumentError.new("Invalid room number") if !(@room_num.is_a? Integer)
    end

  end #room
end # module
