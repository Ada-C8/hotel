module Hotel
  class Room
    attr_reader :number, :status

    def initialize(number, status= :available)
      @number = number
      @status = status
    end
  end
end
