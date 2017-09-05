module Hotel
  class Room

    attr_reader :room_num, :status, :dates_reserved


    def initialize(room_num, status = :open, dates_reserved)
      @room_num = room_num
      @status = status
      @dates_reserved = dates_reserved
    end

  end #room
end # module
