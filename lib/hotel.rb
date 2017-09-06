require 'date'
require_relative 'date_range'
require_relative 'reservation'


class Hotel
  attr_reader :rooms

  def initialize
    # array of rooms
    @rooms = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
    # collection of reservations
    @reservations = Reservation.all
  end

  # def add_reservation(chec)
  #
  # end
  # puts Date.new(2001,2,3)
end
