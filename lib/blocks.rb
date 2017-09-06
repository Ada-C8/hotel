require_relative "reservation"

class Block < Reservation
  def initialize
    super
    @room = []
    @rate = []
    rooms.each do |room|
      @rate.push(room.rate)
    end
    @bill = @rate.inject(:+) * @nights * 0.85
  end
end
