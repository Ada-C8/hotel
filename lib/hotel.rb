module Hotel

  class Room
    attr_reader :num, :reserved, :dates

    def initialize(num, reserved = false)
      @num = num
      @reserved = reserved
      @dates = []
    end

    def self.all
      rooms = []
      (1..20).each do |num|
        rooms << Room.new(num)
      end
      return rooms
    end
  end

end
