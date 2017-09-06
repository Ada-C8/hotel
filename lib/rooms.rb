#ROOM

class Room
  attr_reader :details, :reservations, :rate, :number
  def initialize(number, rate)
    @number = number
    @rate = rate
    @reservations = []
  end

  def add_reservation(check_in, check_out)
    @reservations.push(Reservation.new(check_in, check_out, @rate))
  end






#CLI feature
  # def display_info
  #   @specs.each do |category, info|
  #
  #   end
  # end
end
