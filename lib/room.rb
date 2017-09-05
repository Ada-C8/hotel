require_relative 'hotel.rb'
require 'date'

module Hotel_System

class Room
  attr_reader :room_num, :reserved

  attr_accessor :price

  def initialize(room_num, price)
      @room_num = room_num
      @price = price
  end

#room could have a reservation
#or reservation could have rooms 

  # def reserved?(room_num, date)
  #   if
  #
  #     return true
  #   else
  #     return false
  #   end
  #
  # end


end
end
