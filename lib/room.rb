module Hotel

  class Room
    attr_reader :num

    def initialize(num)
      @num = num
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
