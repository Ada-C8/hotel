require 'date'

module Hotel
  class Room

    attr_reader :room_num, :rate

    def initialize(room_data)
      @room_num = room_data[:room_num]
      @rate = room_data[:rate]
      @dates_reserved = []

      raise ArgumentError.new("room_num is not valid") if !(@room_num.is_a? Integer)

    end


  end #room
end # module
