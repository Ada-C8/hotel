#ROOM

class Room
  attr_reader :details, :reservatoins
  def initialize(number)
    @specs = {number: number,
      rate: 200}
    @reservations = []
  end

  def add_reservation(start, finish)
    #will call on make reseveration
  end






#CLI feature
  # def display_info
  #   @specs.each do |category, info|
  #
  #   end
  # end
end
