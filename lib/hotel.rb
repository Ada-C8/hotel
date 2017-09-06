require_relative 'reservations'
require_relative 'rooms'


module Hotel
  class Hotel

  attr_reader :rooms, :reservations

  def initialize
    @rooms = []
    @reservations = []
    create_rooms
  end



  def create_rooms
    (1..20).each do |num|
      @rooms << Room.new(num)
    end
  end

  end #end of class
end #end of module
