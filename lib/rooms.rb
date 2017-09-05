module Hotel
  class Rooms

    attr_reader :number

    def initialize(number)
      @number = number
    end

    def self.all
      rooms = []
      number = 0
      20.times do
        number += 1
        rooms << self.new(number)
      end 
    end

  end
end
