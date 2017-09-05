require_relative 'hotel.rb'

module Hotel_System

class Room
  attr_reader :room_num, :price

  def initialize(room_num, price)
      @room_num = room_num
      @price = price
  end



  def reserved?

  end


end
end
