require_relative 'hotel'

module Hotel
  class Room
    attr_reader :id, :cost
    def initialize(input_id, cost)
      @id = input_id
      @cost = cost
    end # => end of initialize
  end # => end of class
end # => end of module
