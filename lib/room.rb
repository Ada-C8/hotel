module Hotel
  class Room
    include Comparable
    attr_reader :number, :cost

    def initialize(number, cost)
      @number = number
      @cost = cost
    end

    def <=>(other)
      @number <=> other.number
    end
  end
end
