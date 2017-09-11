require 'date'

class Hotel
  attr_accessor :rooms

  def initialize
    @rooms = []

    id = 1
    20.times do
      @rooms << Room.new(id)
      id += 1
    end
  end

  def list
    return @rooms
  end

end # end of class
