module Hotel
  class Room
    attr_reader :number, :status

    def initialize(number)
      @number = number
    end
  end
end
